class Branchify < Formula
  desc "Convert an arbitrary string into a valid git branch name"
  homepage "https://github.com/murshid1988/branchify"
  url "https://github.com/murshid1988/branchify/archive/refs/tags/v1.1.4.tar.gz"
  sha256 "2219558ffc4a81c93b6cb1558f759cdb24a18162899d0ca943842215c89545dd"
  license "MIT"

  def install
    bin.install "branchify.sh" => "branchify"
    man1.install "branchify.1"
  end

  test do
    assert_equal "hello-world", shell_output("#{bin}/branchify 'Hello World'").strip
  end
end
