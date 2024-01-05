#variables
x = 23
y = 10
z = x+y
print(z)
#list
list = c(1:9)
heros = c("a","b","c","d","e","f","g","h","i")
print(list)
print(heros)
#matrix
matrix_data1 = matrix(list, nrow = 3, ncol = 3)
matrix_data2 = matrix(heros, nrow = 3, ncol = 3)
print(matrix_data1)
print(matrix_data2)
#list_Within_list
my_list <- list(name = c("a","b","c","d","e","f","g","h","i"), age = c(1:9))
print(my_list)
#data frame or table 
df <- data.frame(name = c("a","b","c","d","e","f","g","h","i"), age = c(11:19))
print(df)
#conditions
if (list(2)> 5) {
  print(heros)
} else {
  print("null")
}
