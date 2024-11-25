extends Label

var score: int

func _process(delta):
	score += 1
	self.text = str(score)
