import os
import sys
import argparse
from dotenv import load_dotenv
from markitdown import MarkItDown
from openai import OpenAI

# Load .env from backend directory
load_dotenv("backend/.env")

def main():
    parser = argparse.ArgumentParser(description="Convert PDF to Markdown with OCR using Gemini.")
    parser.add_argument("--input", default="content/Suomen-mestari-1-suomen-kielen-oppikirja-aikuisille.pdf", help="Path to PDF")
    parser.add_argument("--output", default="content/output_ocr.md", help="Path to output markdown")
    parser.add_argument("--model", default="gemini-1.5-flash", help="Gemini model to use")
    args = parser.parse_args()

    gemini_api_key = os.getenv("GEMINI_API_KEY")

    if not gemini_api_key:
        print("Error: GEMINI_API_KEY not found in backend/.env")
        print("Please check your .env file.")
        sys.exit(1)

    print(f"--- MarkItDown OCR with Gemini ---")
    print(f"Input: {args.input}")
    print(f"Output: {args.output}")
    print(f"Model: {args.model}")

    # Initialize OpenAI-compatible client for Gemini
    client = OpenAI(
        api_key=gemini_api_key,
        base_url="https://generativelanguage.googleapis.com/v1beta/openai/"
    )

    # Initialize MarkItDown with OCR plugin
    try:
        md = MarkItDown(
            enable_plugins=True,
            llm_client=client,
            llm_model=args.model
        )
    except Exception as e:
        print(f"Failed to initialize MarkItDown: {e}")
        print("Ensure 'markitdown' and 'markitdown-ocr' are installed.")
        return

    print("Converting... (This can take several minutes for scanned textbooks)")

    try:
        # Convert the document
        result = md.convert(args.input)
        
        # Save the output
        with open(args.output, "w", encoding="utf-8") as f:
            f.write(result.text_content)
            
        print(f"SUCCESS!")
        print(f"Converted content saved to: {args.output}")
        print(f"Context length: {len(result.text_content)} chars")

    except Exception as e:
        print(f"ERROR: {e}")

if __name__ == "__main__":
    main()
