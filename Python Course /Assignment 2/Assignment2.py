#!/usr/bin/env python
# coding: utf-8

# # Problem 1

# In[17]:


x = [0.18, 1.0, 0.92, 0.07, 0.85, 0.99, 0.87]
y = [109.85, 155.72, 137.66, 76.17, 139.75, 162.6, 151.77]

def gradient(w, c):
    dw = 0  # Initialize the gradient of the weight to zero
    dc = 0  # Initialize the gradient of the intercept to zero

    for i in range(len(x)):
        ypred = x[i] * w + c  # Calculate the predicted y-value using the current w and c
        dw += x[i] * (ypred - y[i])  # Update the gradient of the weight
        dc += (ypred - y[i])  # Update the gradient of the intercept

    dw /= len(x)  # Average the weight gradient over all data points
    dc /= len(x)  # Average the intercept gradient over all data points

    return dw, dc  # Return the calculated weight and intercept gradients

w = 0  # Initialize the weight to zero
c = 0  # Initialize the intercept to zero
learning_rate = 0.001  # Set the learning rate for gradient descent

num_iterations = 1  # Set the number of iterations for gradient descent

for i in range(num_iterations):
    dw, dc = gradient(w, c)  # Calculate the gradients of w and c
    w -= learning_rate * dw  # Update the weight using gradient descent
    c -= learning_rate * dc  # Update the intercept using gradient descent

print(round(w,6))
print(c)


# In[18]:


def gradient(w, c):
    dw = 0
    dc = 0

    for i in range(len(x)):
        ypred = x[i] * w + c
        dw += x[i] * (ypred - y[i])
        dc += (ypred - y[i])

    dw /= len(x)
    dc /= len(x)

    return dw, dc

w = 0
c = 0
learning_rate = 0.001

num_iterations = 200 #just changed num_iterations

for i in range(num_iterations):
    dw, dc = gradient(w, c)
    w -= learning_rate * dw
    c -= learning_rate * dc

print(round(w,6))
print(round(c,6))


# # Problem 2

# In[8]:


x = [True, True, False, False, True, False, True]
y = [False, True, True, True, False, False, True]

result_and= []
result_or= []
result_not_x= []

# Iterate through corresponding elements of lists x and y using zip
for i, j in zip(x, y):
    result_and.append(i and j)  # Calculate the 'and' operation result and append it to the result_and list
    result_or.append(i or j)    # Calculate the 'or' operation result and append it to the result_or list
    result_not_x.append(not i)  # Calculate the 'not' operation on 'x' and append the result to the result_not_x list

print(result_and)
print(result_or)
print(result_not_x)


# # Problem 2.2

# In[34]:


x = [True, True, False, False, True]
y = [True, False, False, False, False]

# Check for x
xcount = x.count(True)  # Count the number of True values in the list x
xperc = xcount / len(x)  # Calculate the percentage of True values in x

if xperc >= 0.4:
    print('true')  # If the percentage is greater than or equal to 40%, print 'true'
else:
    print('false') 

# Check for y
ycount = y.count(True)  # Count the number of True values in the list y
yperc = ycount / len(y)  # Calculate the percentage of True values in y

if yperc >= 0.4:
    print('true')  # If the percentage is greater than or equal to 40%, print 'true'
else:
    print('false')  


# # Problem 3

# In[38]:


string = 'python is an interpreted dynamic programming language'
list_A = list(string)  # Convert the string into a list of characters

char = {}  # Initialize an empty dictionary to count character occurrences

# Iterate through the characters in list_A
for i in list_A:
    if i != ' ':  # Exclude spaces
        if i in char:
            char[i] += 1  # Increment the count for an existing character
        else:
            char[i] = 1  # Initialize the count for a new character

print(char)


# In[41]:


for i,count in char.items():
        if count > 1:
            print(i, count)


# # Problem 4

# In[43]:


list_A = [1, 2, 3, 4, 5, 6]
total = 0  # Initialize a variable to keep track of the sum of elements
count = 0  # Initialize a variable to keep track of the number of elements

# Iterate through the elements in list_A
for i in list_A:
    total += i  # Add the current element to the running total
    count += 1  # Increment the count of elements
    mean = total / count  # Calculate the mean by dividing the total by the count
    
print(mean)

