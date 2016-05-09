function li_ikegami(grid, vals)
    n = length(grid)
    m = length(vals)

    if n != m
        print("grid size and value siza is not equal")
    end

    mat = [grid vals]
    mat = sortrows(mat, by = x->(x[1]))
    mat = transpose(mat)

    grid = mat[1, :]
    vals = mat[2, :]

    slope = Array(Float64, n-1)
    for i in 1: (n-1)
        temp_slope = (vals[i] - vals[i+1]) / (grid[i] - grid[i+1])
        slope[i] = temp_slope
    end
    function approx(x_val)

        if x_val > maximum(grid)
            return print("too big value ...")
        end

        if x_val < minimum(grid)
            return print("too small value ...")
        end

        interval = 1
        for j in 1:(n-1)
            if x_val > grid[j+1]
                interval += 1
            else break
            end
        end
        return slope[interval] * (x_val - grid[interval]) + vals[interval]
    end

    function approx{T<:Real}(x::AbstractVector{T})
        n = length(x)
        out = Array(Float64, n)
        for i in 1:n
            out[i] = approx(x[i])
        end
        return out
    end

    return approx
end
