local guard = require("meido.guard")

local actions = {}

actions.simple_tween = function(knottee, initial, final, mapper)
    guard.non_nil("knottee", knottee)
    guard.can_add("initial", initial)
    guard.can_sub("final", final)

    local change = final - initial

    if mapper then
        guard.callable("mapper", mapper)
        return function(time, env)
            env:knot(knottee, mapper(initial + change * time))
        end
    else
        return function(time, env)
            env:knot(knottee, initial + change * time)
        end
    end
end

actions.tween = function(knottee, initial, final, easing_func, mapper)
    guard.non_nil("knottee", knottee)
    guard.can_add("initial", initial)
    guard.can_sub("final", final)
    guard.callable("easing_func", easing_func)

    local change = final - initial

    if mapper then
        guard.callable("mapper", mapper)
        return function(time, env)
            env:knot(knottee,
                mapper(easing_func(time, initial, change)))
        end
    else
        return function(time, env)
            env:knot(knottee,
                easing_func(time, initial, change))
        end
    end
end

return actions