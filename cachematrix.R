## cachematrix.R -- Assignment 2 of "R-programming" by Roger Peng, Coursera, John Hopkins.
## Computes the inverse of special matrix-like object which is cached for
##      future computations.
## makeCacheMatrix: This function creates our matrix-like object
##      and can cache its inverse.
## cacheSolve:  This function computes the inverse of our matrix-like object
##      returned by makeCacheMatrix() above. If the inverse has already been
##      calculated (and the matrix has not changed), then cacheSolve()
##      should retrieve the inverse from the cache.

## The first function, makeCacheMatrix() creates a function
## which contains four functions to:
## 1. set the value of the matrix
## 2. get the value of the matrix
## 3. set the value of the inverse
## 4. get the value of the inverse

makeCacheMatrix <- function(x = matrix()) {
    inv <- NULL
    set <- function(y) {    ## set() stores the matrix as 'x',
        x <<- y             ##   so 'x' is our cached matrix.
        inv <<- NULL        ## 'inv' is our cached inverse matrix,
    }                       ##   and is null until setinv().
    get <- function() x     ## Retrieves our matrix 'x'.
    setinv <- function(solved) inv <<- solved ## Called by cacheSolve().
    getinv <- function() inv   ## Retrieves our inverse matrix 'inv'.
    list(set = set, get = get,
         setinv = setinv,
         getinv = getinv)
}

## The second function calculates the inverse of a special
## "matrix" created with the above function.
## However, it first checks to see if the inverse has already been
## calculated. If so, it gets the inverse from the cache and skips
## the computation. Otherwise, it calculates the inverse of the data
## and sets the inverse in the cache via the makeCacheMatrix function.

cacheSolve <- function(x, ...) {
    ## Return a matrix that is the inverse of 'x'
    inv <- x$getinv()
    if(!is.null(inv)) {
        message("getting cached data")
        return(inv)
    }
    data <- x$get()
    inv <- solve(data, ...)
    x$setinv(inv)
    inv
}

## Testing procedure:
# source("cacheMatrix.R")
# M <- matrix( rnorm(3*3,mean=0,sd=1), 3, 3)  # A random invertible matrix
# Mi <- solve(M)          # and it's inverse.
# zapsmall(Mi %*% M)      # Ensure that their product is the identity matrix.
# N <- makeCacheMatrix(M) # cache matrix M with our function.
# class(get("x",environment(N$get)))    # Our matrix is in there!
# Ni <- cacheSolve(N)     # get inverse with our function.
# identical(Ni,Mi)        # Is our function's result the same the solve()'d inverse?
# Nj <- cacheSolve(N)     # Test the cache. Should return "getting cached data".
# identical(Ni,Nj)        # Is the cached result the same?
# class(get("inv",environment(N$getinv))) # Our inverse is cached in N as well!
#