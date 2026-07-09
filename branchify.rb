class Branchify < Formula
  desc "Convert an arbitrary string into a valid git branch name"
  homepage "https://github.com/murshid1988/branchify"
  url "https://github.com/murshid1988/branchify/archive/refs/tags/v1.1.3.tar.gz"
  sha256 "39344220ba5fd9cbbba6a113816fe29b87d22cabe5497f88c4f1975c02190303"
  license "MIT"

  def install
    bin.install "branchify.sh" => "branchify"
    man1.install "branchify.1"
  end

  test do
    assert_equal "hello-world", shell_output("#{bin}/branchify 'Hello World'").strip
  end
end
