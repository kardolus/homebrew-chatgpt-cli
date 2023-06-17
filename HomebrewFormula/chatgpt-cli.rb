class ChatgptCli < Formula
  desc "A CLI for the OpenAI ChatGPT API"
  homepage "https://github.com/kardolus/chatgpt-cli"
  version "1.1.0"

  if Hardware::CPU.intel?
    url "https://github.com/kardolus/chatgpt-cli/releases/download/v#{version}/chatgpt-darwin-amd64"
    sha256 "f6e5a3c88f52267cc7626adf98dcc63d33fd99fddf7cf349f450727690490e51"
  elsif Hardware::CPU.arm?
    url "https://github.com/kardolus/chatgpt-cli/releases/download/v#{version}/chatgpt-darwin-arm64"
    sha256 "29a5580ef285b8f4d6c5d36873f5cb1d365d33dc0d9bbdd6d5a5e851a1acc64c"
  end

  def install
    if Hardware::CPU.intel?
        bin.install "chatgpt-darwin-amd64" => "chatgpt"
    elsif Hardware::CPU.arm?
        bin.install "chatgpt-darwin-arm64" => "chatgpt"
    end
  end

  test do
    system "#{bin}/chatgpt", "--help"
  end

  def caveats
    <<~EOS
      To enable history tracking across CLI calls, create a ~/.chatgpt-cli directory using the command:

      mkdir -p ~/.chatgpt-cli

      Additionally, set the OPENAI_API_KEY environment variable to your OpenAI API key:

      export OPENAI_API_KEY="your_api_key"

      You can add the above line to your shell profile (e.g., ~/.bashrc, ~/.zshrc, or ~/.bash_profile) to have the variable automatically set in new shell sessions.
    EOS
  end
end

