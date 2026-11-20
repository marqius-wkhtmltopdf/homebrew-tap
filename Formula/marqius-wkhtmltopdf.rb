# The version, url and sha256 lines are written by .github/follow-release.py from
# https://marqius.com/download/marqius-wkhtmltopdf/latest after every release.
class MarqiusWkhtmltopdf < Formula
  desc "Drop-in wkhtmltopdf replacement for HTML to PDF (commercial, 30-day trial)"
  homepage "https://marqius.com/wkhtmltopdf/"
  url "https://marqius.com/download/marqius-wkhtmltopdf/0.12.10/marqius-wkhtmltopdf-linux-x86_64"
  version "0.12.10"
  sha256 "8290e3b4d9b521ea4addc595fff62febd09ec5ae0fa69c037c6453f1177e9098"
  license :cannot_represent

  livecheck do
    url "https://marqius.com/download/marqius-wkhtmltopdf/latest"
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    on_arm do
      url "https://marqius.com/download/marqius-wkhtmltopdf/0.12.10/marqius-wkhtmltopdf-macos-arm64"
      sha256 "4ffe12c0a58352166de83a37c9bc0c0258f3af435a6c8f44f3fb3694dc2d34d2"
    end

    # the macOS build is for Apple silicon; for Intel Macs, write to hello@marqius.com
    depends_on arch: :arm64
  end

  on_linux do
    on_arm do
      url "https://marqius.com/download/marqius-wkhtmltopdf/0.12.10/marqius-wkhtmltopdf-linux-arm64"
      sha256 "5da6bba3f7f0a11c55e1b604d7b86b328430a7ff4371184dc84c3ce6bb34ffaf"
    end
  end

  def install
    program = Dir["marqius-wkhtmltopdf-*"].first
    chmod 0755, program
    bin.install program => "marqius-wkhtmltopdf"
    # The names libraries look for, kept in a folder of their own so they never hide another wkhtmltopdf
    (libexec/"bin").install_symlink bin/"marqius-wkhtmltopdf" => "wkhtmltopdf"
    (libexec/"bin").install_symlink bin/"marqius-wkhtmltopdf" => "wkhtmltoimage"
  end

  def caveats
    <<~EOS
      marqius-wkhtmltopdf is commercial software with a 30-day free trial, counted from its first run;
      `marqius-wkhtmltopdf licence` shows the days left. After the trial, without a licence, each page
      carries one line saying the copy is unlicensed. Plans: https://marqius.com/wkhtmltopdf/

      It is installed as marqius-wkhtmltopdf, so it never hides another wkhtmltopdf. Point your library at
        #{opt_bin}/marqius-wkhtmltopdf
      (`marqius-wkhtmltopdf help libraries` lists how for each library), or give it the names
      wkhtmltopdf and wkhtmltoimage by putting this folder first on your PATH:
        export PATH="#{opt_libexec}/bin:$PATH"
    EOS
  end

  test do
    assert_match "marqius-wkhtmltopdf #{version}", shell_output("#{bin}/marqius-wkhtmltopdf --version")
    assert_match "compatible; marqius-wkhtmltopdf #{version}", shell_output("#{libexec}/bin/wkhtmltopdf -V")

    (testpath/"invoice.html").write "<html><body><h1>Invoice 42</h1><p>Total 1,234.50</p></body></html>"
    system bin/"marqius-wkhtmltopdf", "-q", "invoice.html", "invoice.pdf"
    assert_equal "%PDF-", File.binread(testpath/"invoice.pdf", 5)
    system libexec/"bin/wkhtmltoimage", "-q", "--width", "400", "invoice.html", "invoice.png"
    assert_equal "\x89PNG".b, File.binread(testpath/"invoice.png", 4)
  end
end
