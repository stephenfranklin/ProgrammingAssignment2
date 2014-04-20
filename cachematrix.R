## cachematrix.R -- Assignment 2 of "R-programming" by Roger Peng, Coursera, John Hopkins.
## Computes the inverse of special matrix-like object which is cached for
##      future computations.
## makeCacheMatrix: This function creates our matrix-like object
##      and can cache its inverse.
## cacheSolve:  This function computes the inverse of our matrix-like object
##      returned by makeCacheMatrix() above. If the inverse has already been
##      calculated (and the matrix has not changed), then cacheSolve()
##      should retrieve the inverse from the cache.

## The first function, makeCacheMatrix() creates a list
## which contains up to 2 matrices and four functions to:
## 1. set the value of the matrix
## 2. get the value of the matrix
## 3. set the value of the inverse
## 4. get the value of the inverse

makeCacheMatrix <- function(x = matrix()) {
    inv <- NULL
    set <- function(y) {                        ## set() stores: the matrix as 'x',
        x <<- y                                 ##   so 'x' is our cached matrix, and
        inv <<- NULL                            ## 'inv' is our cached inverse matrix,
    }                                           ##   which is null until setinv().
    get <- function() x                         ## Retrieves our matrix 'x'.
    setinv <- function(solved) inv <<- solved   ## Called by cacheSolve().
    getinv <- function() inv                    ## Retrieves our inverse matrix 'inv'.
    list(set = set, get = get,                  ## Lists the properties and methods
         setinv = setinv,                       ##  that we may access.
         getinv = getinv)
}

## cacheSolve() takes a makeCacheMatrix list and calculates
## the inverse of the matrix 'x'.
## However, it first checks to see if the inverse has already been
## calculated. If so, it gets the inverse from the cache and skips
## the computation. Otherwise, it calculates the inverse of
## the matrix and caches it to 'inv' via the makeCacheMatrix function.

cacheSolve <- function(x, ...) {                ## The '...' arg accommodates our makeCacheMatrix list.
    inv <- x$getinv()                           ## getinv() retrieves NULL from the list
    if(!is.null(inv)) {                         ##   or the cached inverse matrix.
        message("getting cached data")
        return(inv)
    }
    data <- x$get()                             ## get() retrieves our matrix (non-inversed)
    inv <- solve(data, ...)                     ##   from our makeCacheMatrix list.
    x$setinv(inv)                               ## setinv() caches the inverse in our list.
    inv                                         ## Why isn't this "return(inv)" which also works?
}

## Testing procedure:
# source("cacheMatrix.R")                       # Be sure to comment this section out.
# M <- matrix( rnorm(3*3,mean=0,sd=1), 3, 3)    # A random invertible matrix
# Mi <- solve(M)                                # and it's inverse.
# zapsmall(Mi %*% M)        # Ensure that their product is the identity matrix.
# N <- makeCacheMatrix(M)                       # cache matrix M with our function.
# class(get("x",environment(N$get)))            # Our matrix is in there!
# Ni <- cacheSolve(N)                           # get inverse with our function.
# identical(Ni,Mi)                              # Is our function's result the same as the solve()'d inverse?
# Nj <- cacheSolve(N)                           # Test the cache. Should return "getting cached data".
# identical(Ni,Nj)                              # Is the cached result the same?
# class(get("inv",environment(N$getinv)))       # Our inverse is cached in N as well!
# zapsmall(get("inv",environment(N$getinv)) %*% get("x",environment(N$get))) ## just for overkill.
#
