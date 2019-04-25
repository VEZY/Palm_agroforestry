make_website= function(){
  all_files= list.files(recursive = TRUE)
  rmd_files= all_files[grep(".Rmd",all_files)]
  rmd_files= rmd_files[-grep("README.Rmd",rmd_files)]
  NbCores= parallel::detectCores()-1
  cl= parallel::makeCluster(NbCores)
  # parallel::clusterExport(cl=cl,
  #                         varlist=c("dir.orig","dir.targ","usm_name","stics",
  #                                   "obs_name","Out_var","import_usm",
  #                                   "set_out_var","Plant","run_stics",
  #                                   "eval_output","Parameter","Erase","method",
  #                                   "set_param","Param_val"),
  #                         envir=environment())
  outputs=
    parallel::parLapply(cl,rmd_files,function(x){
      rmarkdown::render(input= x,
                        output_format = "html_document",
                        output_dir= "docs",
                        output_file = paste0(gsub(".Rmd","",basename(x)),".html"))
    })
  parallel::stopCluster(cl)
}



