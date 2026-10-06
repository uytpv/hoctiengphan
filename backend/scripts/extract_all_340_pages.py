import os
import pypdf
from pathlib import Path

def extract_all_pages():
    pdf_path = Path("content/Suomen-mestari-1-suomen-kielen-oppikirja-aikuisille.pdf")
    output_dir = Path("content/book_pages")
    output_dir.mkdir(parents=True, exist_ok=True)

    print(f"Opening {pdf_path}...")
    reader = pypdf.PdfReader(str(pdf_path))
    total_pages = len(reader.pages)
    print(f"Total pages in PDF: {total_pages}")

    for idx, page in enumerate(reader.pages):
        page_num = idx + 1
        output_file = output_dir / f"page_{page_num:03d}.jpg"
        
        # If already extracted, skip
        if output_file.exists() and output_file.stat().st_size > 1000:
            continue

        try:
            if len(page.images) > 0:
                with open(output_file, "wb") as f:
                    f.write(page.images[0].data)
            else:
                print(f"[!] Page {page_num} has no images!")
        except Exception as e:
            print(f"[X] Error extracting page {page_num}: {e}")

        if page_num % 20 == 0 or page_num == total_pages:
            print(f"[+] Extracted {page_num}/{total_pages} pages...")

    print(f"[SUCCESS] All {total_pages} pages extracted into {output_dir}/")

if __name__ == "__main__":
    extract_all_pages()
