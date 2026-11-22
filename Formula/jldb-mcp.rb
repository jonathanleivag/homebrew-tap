class JldbMcp < Formula
  desc "stdio MCP bridge for JLDB (Cursor and Claude)"
  homepage "https://github.com/jonathanleivag/jldb-releases"
  url "https://github.com/jonathanleivag/jldb-releases/releases/download/jldb-mcp-v0.1.0/jldb-mcp-0.1.0.tgz"
  sha256 "f4a97bf4fa93da92cb16887686055e50c1d0ebcb8100c6fe0a2071b2c58a5d68"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  def caveats
    <<~EOS
      JLDB must be running (brew install --cask jonathanleivag/tap/jldb).

      Add to Cursor ~/.cursor/mcp.json or Claude Desktop config:

        {
          "mcpServers": {
            "jldb": {
              "command": "jldb-mcp"
            }
          }
        }

      Then restart Cursor/Claude and ask things like:
      "busca Hadda en QA y usuarios con customer id 16066"
    EOS
  end

  test do
    assert_predicate bin/"jldb-mcp", :exist?
  end
end
