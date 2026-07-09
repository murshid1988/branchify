class Branchify < Formula
  desc "Convert an arbitrary string into a valid git branch name"
  homepage "https://github.com/murshid1988/branchify"
  url "https://github.com/murshid1988/branchify/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "cb636d91e53afa39a06ccc56b9ccbb1aa8202ed39b7934c545712e30cbf4e11f"
  license "MIT"

  def install
    bin.install "to-branch-name.sh" => "branchify"
    man1.install "branchify.1"
  end

  test do
    assert_equal "hello-world", shell_output("#{bin}/branchify 'Hello World'").strip
  end
end
