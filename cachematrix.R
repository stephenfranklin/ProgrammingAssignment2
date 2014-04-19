## cachematrix.R
## Computes a the inverse of special matrix-like object which is cached for
##      future computations.
## makeCacheMatrix: This function creates a special "matrix" object that can
##      cache its inverse.
## cacheSolve:  This function computes the inverse of the special "matrix"
##      returned by makeCacheMatrix above. If the inverse has already been
##      calculated (and the matrix has not changed), then the cachesolve
##      should retrieve the inverse from the cache.

## The first function, makeCacheMatrix creates a special "matrix",
## which is really a list of lists containing a function to:
## 1. set the value of the matrix
## 2. get the value of the matrix
## 3. set the value of the inverse
## 4. get the value of the inverse

makeCacheMatrix <- function(x = matrix()) {

}


## The second function calculates the inverse of the special
## "matrix" created with the above function.
## However, it first checks to see if the inverse has already been
## calculated. If so, it gets the inverse from the cache and skips
## the computation. Otherwise, it calculates the inverse of the data
## and sets the inverse in the cache via the makeCacheMatrix function.

cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
}
