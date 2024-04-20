class ChatgptCli < Formula
  desc "A CLI for the OpenAI ChatGPT API"
  homepage "https://github.com/kardolus/chatgpt-cli"
  version "1.5.5"

  if Hardware::CPU.intel?
    url "https://github.com/kardolus/chatgpt-cli/releases/download/v#{version}/chatgpt-darwin-amd64"
    sha256 "ba290456b9c6dd99da9f12a5a87b3a684774bf501c3a436abddaba89be3a186f"
  elsif Hardware::CPU.arm?
    url "https://github.com/kardolus/chatgpt-cli/releases/download/v#{version}/chatgpt-darwin-arm64"
    sha256 "61ff45c8408e8b1900f39dda7034e9cf0991f816a0414fdc4447ec9dbcdd88ba"
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

