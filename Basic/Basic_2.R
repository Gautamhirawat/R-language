# FUNCTION
# we define a function as 
my_function <- function(x, y) {
  result <- x + y
  return(result)
}

# callling a function 
result <- my_function(3, 5)
print(result)



# TAKING INPUT 
# for string 
user_input <- readline(prompt = "Enter something: ")

# for numeric values 
numeric_input <- as.numeric(readline(prompt = "Enter a number: "))



# DATA STRUCTURE
# vector
my_vector <- c(1, 2, 3)
print(my_vector)

#  matrix
my_matrix <- matrix(1:6, nrow = 2, ncol = 3)
print(my_matrix)

# data frame
my_data_frame <- data.frame(Name = c("Alice", "Bob"), Age = c(25, 30))
print(my_data_frame)




# CONDITION 
x <- 10
if (x > 5) {
  print("x is greater than 5")
} else {
  print("x is not greater than 5")
}


#LOOPS 
# for 
for (i in 1:5) {
  print(i)
}

#while
i <- 1
while (i <= 5) {
  print(i)
  i <- i + 1
}



# PACKAGE
#installing { it should be done in terminal ...}
install.packages("dplyr")

# Loading the package {it is in code}{you can use various functions that a library provide by just loading a library in code}
library(dplyr)
