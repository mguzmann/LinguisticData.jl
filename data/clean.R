files = list.files("./data", pattern="*.rda")

for (file in files){
    load(paste("./data/",file,sep=""))
    name = unlist(strsplit(file, "\\."))[1]
    print(name)
    if(name!="dativeLR"){
        df = eval(parse(text=name))
    } else{
        df = dative
    }
    assign(name, df)
    save(list=name, file =paste("./data1/",file,sep=""))
    rm(list=ls())
}
