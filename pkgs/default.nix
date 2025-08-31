self: super: {
  fcitx5-fluent = self.callPackage ./fcitx5-fluent.nix {};
  mpv-youtube-search = self.mpvScripts.callPackage ./mpv-youtube-search.nix {};
}
