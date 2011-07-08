#!/usr/bin/env escript

main([Filename]) ->
    {ok, Cwd} = file:get_cwd(),
    Deps = find_deps(Cwd),
    code:add_paths(Deps),
    Includes = get_includes(Deps), 
%    io:format("~p~n", Includes),
    compile:file(Filename, [basic_validation,  report,{i, "include"},
            {i, "../include"}, {d, 'TEST'}, {d, 'DEBUG'}]++Includes).

find_deps(Cwd) ->
    case file:list_dir(Cwd++"/deps") of
        {ok, Deps} -> [Cwd++"/deps/"++Dep || Dep <- Deps];
        _ -> []
    end.

get_includes(Deps) ->
    [{i, Dep++"/include"} || Dep <- Deps].
