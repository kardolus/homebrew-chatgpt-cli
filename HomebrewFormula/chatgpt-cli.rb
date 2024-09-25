class ChatgptCli < Formula
  desc "CLI for interacting with the OpenAI and Azure ChatGPT API"
  homepage "https://github.com/kardolus/chatgpt-cli"
  url "https://github.com/kardolus/chatgpt-cli/archive/refs/tags/v1.6.6.tar.gz"
  sha256 "a52558b7c942e5cbc87254ee6c9050aac8e88c767bedace0b83e3f2461781e9d"
  license "MIT"

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s -w
      -X main.GitCommit=homebrew
      -X main.GitVersion=v#{version}
    ]
    system "go", "build", *std_go_args(ldflags:, output: bin/"chatgpt"), "./cmd/chatgpt"
    generate_completions_from_executable(bin/"chatgpt", "--set-completions", base_name: "chatgpt")
  end

  test do
    config_output = shell_output("#{bin}/chatgpt --config")
    assert_match "name", config_output, "Config output should include the name key"

    version_output = shell_output("#{bin}/chatgpt --version")
    assert_match "v#{version}", version_output, "Version output should include the correct version"
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

