{ pkgs, ... }:

final: prev:

{
  nvim-treesitter = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "nvim-treesitter";
    version = "2022-12-12";
    src = pkgs.fetchFromGitHub {
      owner = "nvim-treesitter";
      repo = "nvim-treesitter";
      rev = "ae0317d78a9f6fad78870d6645b60528e13ae6fa";
      sha256 = "16d70n17fli233y4aigsr4ddm2h6myj85p4lsl2xk5sypd5bkczc";
    };
    meta.homepage = "https://github.com/nvim-treesitter/nvim-treesitter";
  };

  nvim-treesitter-context = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "nvim-treesitter-context";
    version = "2022-11-23";
    src = pkgs.fetchFromGitHub {
      owner = "nvim-treesitter";
      repo = "nvim-treesitter-context";
      rev = "5fda0b9a2a9049ecc9900e2d86d9ddebab95b0c5";
      sha256 = "084j8bbvs0f1rah92ddbb5qpj4y4m7nq5rn0ga8bsjpyqnx04q7j";
    };
    meta.homepage = "https://github.com/nvim-treesitter/nvim-treesitter-context";
  };

  nvim-treesitter-pyfold = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "nvim-treesitter-pyfold";
    version = "2022-03-14";
    src = pkgs.fetchFromGitHub {
      owner = "eddiebergman";
      repo = "nvim-treesitter-pyfold";
      rev = "46e0c3ebed0934fffcc2a23b52393059b76bff3f";
      sha256 = "1fwmwkpnr0cy663cy5yx5spm5hrv8xhsgvk891dqbm1pydxbpa1z";
    };
    meta.homepage = "https://github.com/eddiebergman/nvim-treesitter-pyfold";
  };

  nvim-treesitter-refactor = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "nvim-treesitter-refactor";
    version = "2022-05-13";
    src = pkgs.fetchFromGitHub {
      owner = "nvim-treesitter";
      repo = "nvim-treesitter-refactor";
      rev = "75f5895cc662d61eb919da8050b7a0124400d589";
      sha256 = "1wpszy4mga9piq5c5ywgdw15wvff8l8a7a6agygfv1rahfv3087j";
    };
    meta.homepage = "https://github.com/nvim-treesitter/nvim-treesitter-refactor";
  };

  nvim-treesitter-textobjects = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "nvim-treesitter-textobjects";
    version = "2022-12-12";
    src = pkgs.fetchFromGitHub {
      owner = "nvim-treesitter";
      repo = "nvim-treesitter-textobjects";
      rev = "731be7f2358fb9f3e2bc7d8698b82c882cf132a4";
      sha256 = "08wfd3ykas1pzqmfljk0945fp78337jfnl0maqws6il5f5l8lbzg";
    };
    meta.homepage = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects";
  };

  nvim-ts-autotag = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "nvim-ts-autotag";
    version = "2022-08-11";
    src = pkgs.fetchFromGitHub {
      owner = "windwp";
      repo = "nvim-ts-autotag";
      rev = "fdefe46c6807441460f11f11a167a2baf8e4534b";
      sha256 = "0cwz18risvkgwr3ppc2vqs6rk94kgra4vmhswn4699fnsmha5lcn";
    };
    meta.homepage = "https://github.com/windwp/nvim-ts-autotag";
  };

  nvim-ts-context-commentstring = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "nvim-ts-context-commentstring";
    version = "2022-10-29";
    src = pkgs.fetchFromGitHub {
      owner = "joosepalviste";
      repo = "nvim-ts-context-commentstring";
      rev = "32d9627123321db65a4f158b72b757bcaef1a3f4";
      sha256 = "176dqn0kxdcsjfxh3nhlkiwh7nrj9792rzbmmrkgghjjw87zrd4p";
    };
    meta.homepage = "https://github.com/joosepalviste/nvim-ts-context-commentstring";
  };

  nvim-ts-rainbow = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "nvim-ts-rainbow";
    version = "2022-11-04";
    src = pkgs.fetchFromGitHub {
      owner = "p00f";
      repo = "nvim-ts-rainbow";
      rev = "064fd6c0a15fae7f876c2c6dd4524ca3fad96750";
      sha256 = "1b7z8xyiplb9rjkdqwijnypjqrssrz5lr1wnl5vk1pyb6dnxspzg";
    };
    meta.homepage = "https://github.com/p00f/nvim-ts-rainbow";
  };
}
