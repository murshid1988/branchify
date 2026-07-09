class Branchify < Formula
  desc "Convert an arbitrary string into a valid git branch name"
  homepage "https://github.com/murshid1988/branchify"
  url "https://github.com/murshid1988/branchify/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "e673d9c5177bc2527e0e3028614bd938924d6dc7a38ba446197f6b9b6ee3e361"
  license "MIT"

  def install
    bin.install "to-branch-name.sh" => "branchify"
    man1.install "branchify.1"
  end

  test do
    assert_equal "hello-world", shell_output("#{bin}/branchify 'Hello World'").strip
  end
end
