# From RDatasets

#################

function dataset(package_name::String, dataset_name::String)
    basename = joinpath(dirname(@__FILE__), "..", "data", package_name)

    rdaname = joinpath(basename, string(dataset_name, ".rda"))
    if isfile(rdaname)
        return DataFrame(read_rda(rdaname)[dataset_name])
    end

    filename = joinpath(basename, string(dataset_name, ".csv.gz"))
    if !isfile(filename)
        error(@sprintf "Unable to locate file %s or %s\n" rdaname filename)
    else
        return readtable(filename)
    end
end


function dataset(dataset_name::String)
    basename = joinpath(dirname(@__FILE__), "..", "data")

    rdaname = joinpath(basename, string(dataset_name, ".rda"))
    if isfile(rdaname)
        data = read_rda(rdaname)[dataset_name]
        print(typeof(data))
        try
            return DataFrame(data)
        catch
            return data.data #This handles datasest that are just a vector of text
        end
    end
    filename = joinpath(basename, string(dataset_name, ".csv"))
    if isfile(filename)
        return readtable(filename)
    end
    filename = joinpath(basename, string(dataset_name, ".csv.gz"))
    if !isfile(filename)
        error(@sprintf "Unable to locate file %s or %s\n" rdaname filename)
    else
        return readtable(filename)
    end
end
