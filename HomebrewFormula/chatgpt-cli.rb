class ChatgptCli < Formula
  desc "A CLI for the OpenAI ChatGPT API"
  homepage "https://github.com/kardolus/chatgpt-cli"
  version "1.2.0"

  if Hardware::CPU.intel?
    url "https://github.com/kardolus/chatgpt-cli/releases/download/v#{version}/chatgpt-darwin-amd64"
    sha256 "349dbb26488fffd3124da149d1c2dbbb2156c4cf183b5c1df9bf77e896cd4f3d"
  elsif Hardware::CPU.arm?
    url "https://github.com/kardolus/chatgpt-cli/releases/download/v#{version}/chatgpt-darwin-arm64"
    sha256 "3e704555f6ab2fbb75af84bf0a59c406153e976d55a981a378be6dc44438765d"
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

