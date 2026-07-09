class Branchify < Formula
  desc "Convert an arbitrary string into a valid git branch name"
  homepage "https://github.com/murshid1988/branchify"
  url "https://github.com/murshid1988/branchify/archive/refs/tags/v1.1.2.tar.gz"
  sha256 "b9a5defe7ecdae473a2b4273ecee61bd0a7031996c0aa494469c32f93ce6ef6f"
  license "MIT"

  def install
    bin.install "branchify.sh" => "branchify"
    man1.install "branchify.1"
  end

  test do
    assert_equal "hello-world", shell_output("#{bin}/branchify 'Hello World'").strip
  end
end
