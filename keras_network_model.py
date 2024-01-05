# first neural network with keras tutorial
from numpy import loadtxt
from keras.models import Sequential
from keras.layers import Dense
# load the dataset
dataset = loadtxt('cat_lanI_pos_nega.csv', delimiter=',')
# split into input (X) and output (y) variables
X = dataset[:,:-1]
y = dataset[:,-1]
# define the keras model
model = Sequential()
model.add(Dense(12, input_dim=400, activation='relu'))
model.add(Dense(8, activation='relu'))
model.add(Dense(1, activation='sigmoid'))
# compile the keras model
model.compile(loss='binary_crossentropy', optimizer='adam', metrics=['accuracy'])
# fit the keras model on the dataset
#model.fit(X, y, epochs=80, batch_size=10)
model.fit(X, y, validation_split=0.3,callbacks=EarlyStopping(monitor='val_loss'))
# evaluate the keras model
_, accuracy = model.evaluate(X, y)
print('Accuracy: %.2f' % (accuracy*100))
# make class predictions with the model
predictions = (model.predict(X) > 0.5).astype(int)
# summarize the first 5 cases
for i in range(5):
	print('%s => %d (expected %d)' % (X[i].tolist(), predictions[i], y[i]))
