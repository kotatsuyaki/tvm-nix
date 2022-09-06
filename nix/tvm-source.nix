{ fetchFromGitHub }:

fetchFromGitHub {
  owner = "apache";
  repo = "tvm";
  rev = "v0.7.0";
  fetchSubmodules = true;
  sha256 = "0qflpd3lw0jslyk5lqpv2v42lkqs8mkvnn6i3fdms32iskdfk6p5";
}
