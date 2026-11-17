# Marqius Homebrew tap: wkhtmltopdf replacement

**Marqius by Simple AI LLC** is a maintained, wkhtmltopdf-compatible HTML-to-PDF command-line program for applications that generate invoices, reports, statements and other documents.

Keep your templates and executable-based wrapper library, point the application at Marqius, and compare the resulting PDFs before switching production.

[Product and switching guide](https://marqius.com/wkhtmltopdf/) · [Download Marqius](https://marqius.com/wkhtmltopdf/download/) · [Trial and licence plans](https://marqius.com/wkhtmltopdf-buy/)

> **Homebrew status:** This repository is being prepared for Homebrew distribution. No installable cask or formula has been published here yet. Use the official download and installer below.

## Install Marqius today

The [official installation guide](https://marqius.com/wkhtmltopdf/download/) provides the supported downloads and a platform-detecting installer. The installer verifies the binary's SHA-256 checksum and preserves an existing wkhtmltopdf installation unless you explicitly choose to take over.

Download the installer, review it, then run it:

```sh
curl -fsSL https://marqius.com/marqius-wkhtmltopdf.sh -o marqius-wkhtmltopdf.sh
bash marqius-wkhtmltopdf.sh
```

### Current official downloads

| Operating system | Architecture |
| --- | --- |
| Linux | x86-64 / AMD64 |
| Linux | ARM64 / AArch64 |
| macOS | Apple silicon / ARM64 |

These are the direct-download platforms. This repository does not yet provide Homebrew packages. Windows is not part of the current supported download set.

## Convert HTML to PDF and compare the result

Render a representative document:

```sh
marqius wkhtmltopdf --page-size A4 invoice.html invoice.pdf
```

Compare it with a known-good PDF from your existing workflow:

```sh
marqius compare old.pdf invoice.pdf
```

Check fonts, images, headers, footers and page breaks on your own documents. Font availability can change text widths and pagination; install the fonts your templates use.

## Keep your existing application and wrapper

Marqius supports migration paths for libraries that launch the wkhtmltopdf executable. Usually the integration change is the executable path or command, followed by output checks.

| Application stack | Wrapper or integration | Guide |
| --- | --- | --- |
| Python, Django and Flask | pdfkit, django-wkhtmltopdf, imgkit | [Python migration](https://marqius.com/wkhtmltopdf/python/) |
| PHP and Laravel | KnpLabs Snappy, laravel-snappy | [PHP and Laravel migration](https://marqius.com/wkhtmltopdf/laravel-php/) |
| Ruby and Rails | wicked_pdf, PDFKit | [Ruby and Rails migration](https://marqius.com/wkhtmltopdf/rails-ruby/) |
| .NET on Linux | Rotativa, Wkhtmltopdf.NetCore | [.NET migration](https://marqius.com/wkhtmltopdf/dotnet/) |
| Node.js and Go | Wrappers that start wkhtmltopdf | [Node.js and Go migration](https://marqius.com/wkhtmltopdf/node-go/) |
| Docker and CI | The Linux executable in your own image | [Docker integration](https://marqius.com/wkhtmltopdf/docker/) |

Libraries that load **libwkhtmltox** directly, including DinkToPdf, cannot use this executable as a replacement for that shared library. PDF output is not guaranteed to be identical; validate your representative documents before changing production.

## Frequently asked questions

### Can I install Marqius with brew now?

Not from this tap yet. The official installer and direct downloads are available through the [download guide](https://marqius.com/wkhtmltopdf/download/). Homebrew commands will be documented here when a tested package is published.

### Will it replace my existing wkhtmltopdf automatically?

The official installer preserves the existing program by default. Follow the switching guide and compare your PDFs before explicitly choosing takeover.

### Can I keep PDFKit, Snappy or wicked_pdf?

For executable-based integrations, keep the wrapper and configure it to use the compatible Marqius program. Use the stack-specific guides above to check paths and supported workflows.

### Is Marqius open source?

Marqius is proprietary software from Simple AI LLC. This repository is for Homebrew distribution and documentation; it is not the Marqius engine source. See the [trial and licence plans](https://marqius.com/wkhtmltopdf-buy/) for product licensing.

## Documentation and support

- [wkhtmltopdf switching guide](https://marqius.com/wkhtmltopdf/)
- [Installation and download guide](https://marqius.com/wkhtmltopdf/download/)
- [Switching manual (PDF)](https://marqius.com/download/replace-wkhtmltopdf.pdf)
- [Security and untrusted HTML guidance](https://marqius.com/wkhtmltopdf/security/)
- [Contact Marqius](https://marqius.com/contact/)
- [Report a tap or documentation issue](https://github.com/marqius-wkhtmltopdf/homebrew-tap/issues)

For documents that contain untrusted HTML, apply the file, network and process-isolation controls described in the security guide. Remove private document content before posting a public issue.

Marqius is independent of the wkhtmltopdf project. Other product names identify migration paths and belong to their respective owners.
