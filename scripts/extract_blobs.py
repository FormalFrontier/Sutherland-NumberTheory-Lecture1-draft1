#!/usr/bin/env python3
"""Extract per-blob markdown files from page-level markdown files using items.json."""

import json
import os
import sys

def main():
    repo_root = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    items_path = os.path.join(repo_root, "items.json")
    pages_dir = os.path.join(repo_root, "pages")
    blobs_dir = os.path.join(repo_root, "blobs")

    with open(items_path) as f:
        items = json.load(f)

    # Load all page files into memory (page_id -> list of lines)
    page_ids = set()
    for item in items:
        page_ids.add(item["start_page"])
        page_ids.add(item["end_page"])

    pages = {}
    for pid in sorted(page_ids):
        page_file = os.path.join(pages_dir, f"{pid}.md")
        with open(page_file) as f:
            pages[pid] = f.readlines()

    # Extract each blob
    os.makedirs(blobs_dir, exist_ok=True)

    for item in items:
        blob_id = item["id"]
        start_page = item["start_page"]
        end_page = item["end_page"]
        start_line = item["start_line"]  # 1-indexed
        end_line = item["end_line"]      # 1-indexed, inclusive

        # Collect lines for this blob
        lines = []
        if start_page == end_page:
            # Single page: extract start_line to end_line
            page_lines = pages[start_page]
            lines = page_lines[start_line - 1 : end_line]
        else:
            # Multi-page: from start_line to end of start_page,
            # then full pages in between (if any),
            # then from start of end_page to end_line
            # For this dataset, multi-page blobs span at most 2 pages
            page_lines_start = pages[start_page]
            lines.extend(page_lines_start[start_line - 1 :])

            # Get pages between start and end (for items spanning 3+ pages)
            # In this dataset this doesn't happen, but handle it for correctness
            numeric_pages = sorted([p for p in page_ids if p.isdigit()], key=int)
            non_numeric = sorted([p for p in page_ids if not p.isdigit()])
            ordered_pages = numeric_pages + non_numeric

            start_idx = ordered_pages.index(start_page)
            end_idx = ordered_pages.index(end_page)

            for i in range(start_idx + 1, end_idx):
                lines.extend(pages[ordered_pages[i]])

            page_lines_end = pages[end_page]
            lines.extend(page_lines_end[:end_line])

        # Write blob file
        blob_path = os.path.join(blobs_dir, f"{blob_id}.md")
        os.makedirs(os.path.dirname(blob_path), exist_ok=True)

        with open(blob_path, "w") as f:
            f.writelines(lines)

        print(f"  Extracted {blob_id} ({len(lines)} lines)")

    print(f"\nExtracted {len(items)} blobs to {blobs_dir}/")

    # Verification: concatenate all blobs in order and compare against page files
    print("\n--- Verification ---")

    # Build expected concatenation: all page files in order
    expected_lines = []
    ordered_pages = sorted([p for p in page_ids if p.isdigit()], key=int)
    ordered_pages += sorted([p for p in page_ids if not p.isdigit()])
    for pid in ordered_pages:
        expected_lines.extend(pages[pid])

    # Build actual concatenation: all blobs in items.json order
    actual_lines = []
    for item in items:
        blob_path = os.path.join(blobs_dir, f"{item['id']}.md")
        with open(blob_path) as f:
            actual_lines.extend(f.readlines())

    if expected_lines == actual_lines:
        print("PASS: Concatenation of all blobs exactly matches concatenation of all pages.")
    else:
        print("FAIL: Mismatch detected!")
        print(f"  Expected {len(expected_lines)} lines, got {len(actual_lines)} lines")
        # Find first difference
        for i, (e, a) in enumerate(zip(expected_lines, actual_lines)):
            if e != a:
                print(f"  First difference at line {i+1}:")
                print(f"    Expected: {e.rstrip()}")
                print(f"    Actual:   {a.rstrip()}")
                break
        if len(expected_lines) != len(actual_lines):
            print(f"  Length mismatch: expected {len(expected_lines)}, got {len(actual_lines)}")
        sys.exit(1)

if __name__ == "__main__":
    main()
