class ChatgptCli < Formula
  desc "A CLI for the OpenAI ChatGPT API"
  homepage "https://github.com/kardolus/chatgpt-cli"
  version "1.3.3"

  if Hardware::CPU.intel?
    url "https://github.com/kardolus/chatgpt-cli/releases/download/v#{version}/chatgpt-darwin-amd64"
    sha256 "cb8b6c816af58befb46dc04b8776399e044f0ffe5f155455bc1faf297827f1d3"
  elsif Hardware::CPU.arm?
    url "https://github.com/kardolus/chatgpt-cli/releases/download/v#{version}/chatgpt-darwin-arm64"
    sha256 "a65b426d02750be6aff00b514be7c0642f28ad7e6a769cc27ce4d1f17fd0d696"
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

