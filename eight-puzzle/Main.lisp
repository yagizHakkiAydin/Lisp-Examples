(setf *random-state* (make-random-state t));seed for random numbers


(setq board (make-array '(3 3)))  ;2d array that represents board


(setq finishedBoard (make-array '(3 3)))  ;2d array that is used to check if game has ended


(setf numbers (make-array '(8))) ;1d array that is filled with numbers from 1 to 8



(dotimes (i 8)
	(setf (aref numbers i) (+ i 1))
)




(defun merge-array('array) ;merges numbers array to fill board array with randomly-ordered numbers
		(dotimes (i 15)
			(setq index (random 7))
			(rotatef (aref numbers index) (aref numbers (+ index 1)))
		)

)




(defun initialize-board()  ;randomly chooses empty cells and fills other cells with numbers from numbers array

	(setq emptyCellXIndex (random 3))
	(setq emptyCellYIndex (random 3))

	(setq numberArrayIndex 0)

	(dotimes (y 3)
		(dotimes (x 3)
			(if (or (/= y emptyCellYIndex) (/= x emptyCellXIndex))
				(progn
					(setf (aref board y x) (aref numbers numberArrayIndex))
					(incf numberArrayIndex)
				)
			)
		)
	)

)






(defun print-board()
	(dotimes (y 3)
		(dotimes (x 3)
			(if (equal (aref board y x) nil)
				(progn
					(princ ".")
					(princ "    ")

				)
				(progn
					(write (aref board y x))
					(princ "    ")
				)
			)
		)
		(write-line "")
		(write-line "")
	)
)







(defun hasGameEnded()
		(equal board finishedBoard)
)










(defun move(number)


	(setq isIllegalegal t)

	(if (or (< number 1) (> number 8))
		(progn
			(write-line "Select a correct number to move...")
		)
		(progn

			(setq xIndex (find-x-index-of-given-number number))
			(setq yIndex (find-y-index-of-given-number number))
			(setq hasMoveDone nil)



			(if (or (equal xIndex 0) (equal xIndex 1));sağa gider


				(progn
					(if (equal (aref board yIndex (+ xIndex 1)) nil)
						(progn
							(rotatef (aref board yIndex xIndex) (aref board yIndex (+ xIndex 1)))
							(setq hasMoveDone t)
						)

					)
				)

			)


			(if (equal nil hasMoveDone)
				(progn
					(if (or (equal xIndex 1) (equal xIndex 2));sola gider
						(progn
							(if (equal (aref board yIndex (- xIndex 1)) nil)
								(progn
										(rotatef (aref board yIndex xIndex) (aref board yIndex (- xIndex 1)))
										(setq hasMoveDone t)
								)
							)
						)
					)
				)
			)


			(if (equal nil hasMoveDone)
				(progn
					(if (or (equal yIndex 1) (equal yIndex 2));yukarı gider
						(progn
							(if (equal (aref board (- yIndex 1) xIndex) nil)
								(progn
										(rotatef (aref board yIndex xIndex) (aref board (- yIndex 1) xIndex))
										(setq hasMoveDone t)
								)
							)
						)
					)
				)
			)

			(if (equal nil hasMoveDone)
				(progn
					(if (or (equal yIndex 0) (equal yIndex 1));aşağı gider
						(progn
							(if (equal (aref board (+ yIndex 1) xIndex) nil)
								(progn
										(rotatef (aref board yIndex xIndex) (aref board (+ yIndex 1) xIndex))
										(setq hasMoveDone t)
								)
							)
						)
					)
				)
			)


		)

	)

	isIllegalegal
)







(defun find-x-index-of-given-number(number)

	(defvar xIndex)

	(dotimes (y 3)
		(dotimes (x 3)
			(if (equal (aref board y x) number)
				(progn
					(setq xIndex x)
				)		
			)
		)
	)

	xIndex
)



(defun find-y-index-of-given-number(number)

	(defvar yIndex)

	(dotimes (y 3)
		(dotimes (x 3)
			(if (equal (aref board y x) number)
				(progn
					(setq yIndex y)
				)		
			)
		)
	)


	yIndex
)





(defun start-game(null)
	(merge-array numbers)
	(initialize-board)
)




(defun play-game(null)



	(start-game())





	(loop ;infinite loop for playing game

		(if (eq nil (hasGameEnded))
			(progn
				(print-board)
				(defvar userInput)

				(princ "Which number you will move --> ")
				(setq userInput (read))


				(move userInput)
				(write-line "")
				(write-line "")
				(write-line "")
				(write-line "")




			)
			(progn 
				(write-line "You won")
				(exit)
			)
		)


	)



)










(play-game())  ;----------------------------------->everything starts from here...















