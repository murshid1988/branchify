class Branchify < Formula
  desc "Convert an arbitrary string into a valid git branch name"
  homepage "https://github.com/murshid1988/branchify"
  url "https://github.com/murshid1988/branchify/archive/refs/tags/v1.1.1.tar.gz"
  sha256 "cef1017bbeb677d987efc4b798a7e3dd1eea90dffa9f8bdc4363b3becf23a93c"
  license "MIT"

  def install
    bin.install "branchify.sh" => "branchify"
    man1.install "branchify.1"
  end

  test do
    assert_equal "hello-world", shell_output("#{bin}/branchify 'Hello World'").strip
  end
end
