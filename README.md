# marqius-wkhtmltopdf for Homebrew

Install **marqius-wkhtmltopdf**, the maintained drop-in replacement for wkhtmltopdf, with Homebrew on Apple silicon Macs and on Linux (x86-64 and ARM64).

```bash
brew install marqiushq/tap/marqius-wkhtmltopdf
```

It reads wkhtmltopdf's command line as it is. Try it in an empty folder:

```bash
echo '<h1>Invoice 42</h1><p>Total €1,234.50</p>' > invoice.html
marqius-wkhtmltopdf --page-size A4 invoice.html invoice.pdf
```

## Switch your application

Keep your library, HTML templates and PDF calls, and point the library at marqius-wkhtmltopdf in either of two ways.

**Name its path in the library's settings.** This prints the path to use:

```bash
echo "$(brew --prefix)/bin/marqius-wkhtmltopdf"
```

`marqius-wkhtmltopdf help libraries` lists the libraries it knows, from python-pdfkit and Snappy to wicked_pdf and Rotativa, and `marqius-wkhtmltopdf help snappy` (or another name from that list) shows where each one takes the path.

**Or give it the names wkhtmltopdf and wkhtmltoimage** for everything started from your shell, by putting its own folder of those names first on your PATH. Add the first line to your shell profile to keep it:

```bash
export PATH="$(brew --prefix)/opt/marqius-wkhtmltopdf/libexec/bin:$PATH"
wkhtmltopdf -V
```

Nothing is replaced or hidden: take the line out and the wkhtmltopdf you had before is back.

## Always the latest release

The formula follows every release of marqius-wkhtmltopdf on its own. Each hour [a workflow](.github/workflows/formula.yml) checks marqius.com; a new release is checked against its published checksums, then installed, tested and audited on macOS (Apple silicon) and on Linux (x86-64 and ARM64) before the formula moves to it. Every day it also installs and tests the current formula again on all three. To bring yours up to date:

```bash
brew upgrade marqius-wkhtmltopdf
```

## Licence

marqius-wkhtmltopdf is commercial software from Simple AI LLC, with a 30-day free trial counted from its first run; `marqius-wkhtmltopdf licence` shows the days left. After the trial, without a licence, each page carries one line saying the copy is unlicensed. [Plans and licences](https://marqius.com/wkhtmltopdf/) · [Licence terms](https://marqius.com/licence/marqius-wkhtmltopdf)

## Before you switch

- [wkhtmltopdf parity suite](https://github.com/marqiushq/wkhtmltopdf-parity): the same HTML documents through wkhtmltopdf and marqius-wkhtmltopdf on every release, misses included. Run it on your own templates; nothing is uploaded.
- [Integration examples](https://github.com/marqiushq/marqius-wkhtmltopdf-examples) for 14 wkhtmltopdf libraries.
- [The switching manual](https://marqius.com/download/marqius-wkhtmltopdf/replace-wkhtmltopdf.pdf) (PDF).

Intel Macs have no build yet: write to hello@marqius.com. To remove marqius-wkhtmltopdf, run `brew uninstall marqius-wkhtmltopdf`.
