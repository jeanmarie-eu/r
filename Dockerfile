FROM rocker/r-ver:3.5.1

## Download and install dependencies
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    file \
    git \
		libssh2-1-dev \
		libxml2-dev \
		zlib1g-dev \
    libapparmor1 \
    libclang-dev \
		libcurl4-gnutls-dev \
		libgit2-dev \
    libedit2 \
    libssl-dev \
    lsb-release \
    multiarch-support \
    psmisc \
    procps \
    python-setuptools \
    sudo \
    wget \
  ## configure git not to request password each time
  && git config --system credential.helper 'cache --timeout=3600' \
  && git config --system push.default simple \

## install R packages with their specific version for mirroring my machine
&& R -e "install.packages('https://cran.r-project.org/src/contrib/Archive/git2r/git2r_0.26.1.tar.gz', repos=NULL, type='source')" \
	 && R -e "install.packages('https://cran.r-project.org/src/contrib/Archive/rlang/rlang_0.4.1.tar.gz', repos=NULL, type='source')" \
	 && R -e "install.packages('https://cran.r-project.org/src/contrib/Archive/ellipsis/ellipsis_0.2.0.1.tar.gz', repos=NULL, type='source')" \
	 && R -e "install.packages('https://cran.r-project.org/src/contrib/assertthat_0.2.1.tar.gz', repos=NULL, type='source')" \
	 && R -e "install.packages('https://cran.r-project.org/src/contrib/magrittr_1.5.tar.gz', repos=NULL, type='source')" \
	 && R -e "install.packages('https://cran.r-project.org/src/contrib/Archive/prettyunits/prettyunits_1.0.2.tar.gz', repos=NULL, type='source')" \
	 && R -e "install.packages('https://cran.r-project.org/src/contrib/Archive/ps/ps_1.3.0.tar.gz', repos=NULL, type='source')" \
	 && R -e "install.packages('https://cran.r-project.org/src/contrib/R6_2.4.1.tar.gz', repos=NULL, type='source')" \
	 && R -e "install.packages('https://cran.r-project.org/src/contrib/crayon_1.3.4.tar.gz', repos=NULL, type='source')" \
	 && R -e "install.packages('https://cran.r-project.org/src/contrib/Archive/cli/cli_1.1.0.tar.gz', repos=NULL, type='source')" \
	 && R -e "install.packages('https://cran.r-project.org/src/contrib/Archive/backports/backports_1.1.4.tar.gz', repos=NULL, type='source')" \
	 && R -e "install.packages('https://cran.r-project.org/src/contrib/rprojroot_1.3-2.tar.gz', repos=NULL, type='source')" \
	 && R -e "install.packages('https://cran.r-project.org/src/contrib/desc_1.2.0.tar.gz', repos=NULL, type='source')" \
	 && R -e "install.packages('https://cran.r-project.org/src/contrib/Archive/withr/withr_2.1.2.tar.gz', repos=NULL, type='source')" \
	 && R -e "install.packages('https://cran.r-project.org/src/contrib/Archive/rstudioapi/rstudioapi_0.10.tar.gz', repos=NULL, type='source')" \
	 && R -e "install.packages('https://cran.r-project.org/src/contrib/Archive/Rcpp/Rcpp_1.0.3.tar.gz', repos=NULL, type='source')" \
	 && R -e "install.packages('https://cran.r-project.org/src/contrib/brew_1.0-6.tar.gz', repos=NULL, type='source')" \
	 && R -e "install.packages('https://cran.r-project.org/src/contrib/commonmark_1.7.tar.gz', repos=NULL, type='source')" \
	 && R -e "install.packages('https://cran.r-project.org/src/contrib/Archive/digest/digest_0.6.20.tar.gz', repos=NULL, type='source')" \
	 && R -e "install.packages('https://cran.r-project.org/src/contrib/Archive/purrr/purrr_0.3.3.tar.gz', repos=NULL, type='source')" \
	 && R -e "install.packages('https://cran.r-project.org/src/contrib/Archive/processx/processx_3.4.1.tar.gz', repos=NULL, type='source')" \
	 && R -e "install.packages('https://cran.r-project.org/src/contrib/Archive/callr/callr_3.3.1.tar.gz', repos=NULL, type='source')" \
	 && R -e "install.packages('https://cran.r-project.org/src/contrib/Archive/pkgbuild/pkgbuild_1.0.5.tar.gz', repos=NULL, type='source')" \
	 && R -e "install.packages('https://cran.r-project.org/src/contrib/Archive/pkgload/pkgload_1.0.2.tar.gz', repos=NULL, type='source')" \
	 && R -e "install.packages('https://cran.r-project.org/src/contrib/Archive/xml2/xml2_1.2.2.tar.gz', repos=NULL, type='source')" \
	 && R -e "install.packages('https://cran.r-project.org/src/contrib/Archive/stringi/stringi_1.4.3.tar.gz', repos=NULL, type='source')" \
	 && R -e "install.packages('https://cran.r-project.org/src/contrib/Archive/glue/glue_1.3.1.tar.gz', repos=NULL, type='source')" \
	 && R -e "install.packages('https://cran.r-project.org/src/contrib/stringr_1.4.0.tar.gz', repos=NULL, type='source')" \
	 && R -e "install.packages('https://cran.r-project.org/src/contrib/Archive/roxygen2/roxygen2_6.1.1.tar.gz', repos=NULL, type='source')" \
	 && R -e "install.packages('https://cran.r-project.org/src/contrib/Archive/curl/curl_4.0.tar.gz', repos=NULL, type='source')" \
	 && R -e "install.packages('https://cran.r-project.org/src/contrib/rversions_2.0.2.tar.gz', repos=NULL, type='source')" \
	 && R -e "install.packages('https://cran.r-project.org/src/contrib/Archive/fs/fs_1.3.1.tar.gz', repos=NULL, type='source')" \
	 && R -e "install.packages('https://cran.r-project.org/src/contrib/clipr_0.7.0.tar.gz', repos=NULL, type='source')" \
	 && R -e "install.packages('https://cran.r-project.org/src/contrib/clisymbols_1.2.0.tar.gz', repos=NULL, type='source')" \
	 && R -e "install.packages('https://cran.r-project.org/src/contrib/ini_0.3.1.tar.gz', repos=NULL, type='source')" \
	 && R -e "install.packages('https://cran.r-project.org/src/contrib/Archive/sys/sys_3.3.tar.gz', repos=NULL, type='source')" \
	 && R -e "install.packages('https://cran.r-project.org/src/contrib/askpass_1.1.tar.gz', repos=NULL, type='source')" \
	 && R -e "install.packages('https://cran.r-project.org/src/contrib/Archive/openssl/openssl_1.4.1.tar.gz', repos=NULL, type='source')" \
	 && R -e "install.packages('https://cran.r-project.org/src/contrib/Archive/jsonlite/jsonlite_1.6.tar.gz', repos=NULL, type='source')" \
	 && R -e "install.packages('https://cran.r-project.org/src/contrib/Archive/mime/mime_0.7.tar.gz', repos=NULL, type='source')" \
	 && R -e "install.packages('https://cran.r-project.org/src/contrib/Archive/httr/httr_1.4.1.tar.gz', repos=NULL, type='source')" \
	 && R -e "install.packages('https://cran.r-project.org/src/contrib/Archive/gh/gh_1.0.1.tar.gz', repos=NULL, type='source')" \
	 && R -e "install.packages('https://cran.r-project.org/src/contrib/whisker_0.4.tar.gz', repos=NULL, type='source')" \
	 && R -e "install.packages('https://cran.r-project.org/src/contrib/Archive/yaml/yaml_2.2.0.tar.gz', repos=NULL, type='source')" \
	 && R -e "install.packages('https://cran.r-project.org/src/contrib/Archive/usethis/usethis_1.5.1.tar.gz', repos=NULL, type='source')" \
	 && R -e "install.packages('https://cran.r-project.org/src/contrib/sessioninfo_1.1.1.tar.gz', repos=NULL, type='source')" \
	 && R -e "install.packages('https://cran.r-project.org/src/contrib/Archive/remotes/remotes_2.1.0.tar.gz', repos=NULL, type='source')" \
	 && R -e "install.packages('https://cran.r-project.org/src/contrib/memoise_1.1.0.tar.gz', repos=NULL, type='source')" \
	 && R -e "install.packages('https://cran.r-project.org/src/contrib/xopen_1.0.0.tar.gz', repos=NULL, type='source')" \
	 && R -e "install.packages('https://cran.r-project.org/src/contrib/rcmdcheck_1.3.3.tar.gz', repos=NULL, type='source')" \
	 && R -e "install.packages('https://cran.r-project.org/src/contrib/evaluate_0.14.tar.gz', repos=NULL, type='source')" \
	 && R -e "install.packages('https://cran.r-project.org/src/contrib/praise_1.0.0.tar.gz', repos=NULL, type='source')" \
	 && R -e "install.packages('https://cran.r-project.org/src/contrib/Archive/testthat/testthat_2.2.1.tar.gz', repos=NULL, type='source')" \
	 && R -e "install.packages('https://cran.r-project.org/src/contrib/Archive/devtools/devtools_2.1.0.tar.gz', repos=NULL, type='source')" \
	 && R -e "install.packages('https://cran.r-project.org/src/contrib/Archive/fansi/fansi_0.4.0.tar.gz', repos=NULL, type='source')" \
	 && R -e "install.packages('https://cran.r-project.org/src/contrib/utf8_1.1.4.tar.gz', repos=NULL, type='source')" \
	 && R -e "install.packages('https://cran.r-project.org/src/contrib/zeallot_0.1.0.tar.gz', repos=NULL, type='source')" \
	 && R -e "install.packages('https://cran.r-project.org/src/contrib/Archive/vctrs/vctrs_0.2.0.tar.gz', repos=NULL, type='source')" \
	 && R -e "install.packages('https://cran.r-project.org/src/contrib/Archive/pillar/pillar_1.4.2.tar.gz', repos=NULL, type='source')" \
	 && R -e "install.packages('https://cran.r-project.org/src/contrib/Archive/pkgconfig/pkgconfig_2.0.2.tar.gz', repos=NULL, type='source')" \
	 && R -e "install.packages('https://cran.r-project.org/src/contrib/Archive/tibble/tibble_2.1.3.tar.gz', repos=NULL, type='source')" \
	 && R -e "install.packages('https://cran.r-project.org/src/contrib/Archive/tidyselect/tidyselect_0.2.5.tar.gz', repos=NULL, type='source')" \
	 && R -e "install.packages('https://cran.r-project.org/src/contrib/Archive/BH/BH_1.69.0-1.tar.gz', repos=NULL, type='source')" \
	 && R -e "install.packages('https://cran.r-project.org/src/contrib/plogr_0.2.0.tar.gz', repos=NULL, type='source')" \
	 && R -e "install.packages('https://cran.r-project.org/src/contrib/Archive/dplyr/dplyr_0.8.3.tar.gz', repos=NULL, type='source')"

CMD ["R"]
