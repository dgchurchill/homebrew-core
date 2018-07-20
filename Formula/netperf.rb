class Netperf < Formula
  desc "Benchmarks performance of many different types of networking"
  homepage "https://hewlettpackard.github.io/netperf/"
  url "https://github.com/HewlettPackard/netperf/archive/netperf-2.7.0.tar.gz"
  sha256 "4569bafa4cca3d548eb96a486755af40bd9ceb6ab7c6abd81cc6aa4875007c4e"
  head "https://github.com/HewlettPackard/netperf.git"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "cf086e0d276a572aba8318f7080cedc94b36a7b612cdbb4bcc3ceefef0080c53" => :high_sierra
    sha256 "4d3f648081c84ad697d608b56bcfce3237de7c34c4e4a53d9851628f9d50cd5d" => :sierra
    sha256 "c6e96625b1f83a7f83d3c9b53b8584ab65d73cfd59bc38672588ba82d37ecc1d" => :el_capitan
  end

  def install
    inreplace "src/netlib.c" do |s|
      s.gsub! "inline void demo_interval_display(double actual_interval)", "void demo_interval_display(double actual_interval)"
      s.gsub! "inline void demo_interval_tick(uint32_t units)", "void demo_interval_tick(uint32_t units)"
    end

    system "./configure", "--disable-dependency-tracking",
                          "--enable-demo",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/netperf -h | cat"
  end
end
