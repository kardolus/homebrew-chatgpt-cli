class ChatgptCli < Formula
  desc "A CLI for the OpenAI ChatGPT API"
  homepage "https://github.com/kardolus/chatgpt-cli"
  version "1.1.2"

  if Hardware::CPU.intel?
    url "https://github.com/kardolus/chatgpt-cli/releases/download/v#{version}/chatgpt-darwin-amd64"
    sha256 "ee7df6c681dd4cd376fa5d323837f46d49b3289e275dd9e0cdc5b5acbb1851e5"
  elsif Hardware::CPU.arm?
    url "https://github.com/kardolus/chatgpt-cli/releases/download/v#{version}/chatgpt-darwin-arm64"
    sha256 "877a0290e3704633723a6359d9eba5aaa5e95ee7462d794bb8296a12a3fedee1"
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

