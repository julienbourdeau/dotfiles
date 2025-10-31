function show_size
    set -l path $argv[1]
    if test -z "$path"
        set path .
    end
    du -sbh $path/*
end
