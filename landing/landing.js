var canvas = document.querySelector("#canvAni");
var context = canvas.getContext("2d");

var canvasW = window.innerWidth;
var canvasH = window.innerHeight;

context.canvas.width  = window.innerWidth;
context.canvas.height = window.innerHeight;

var requestAnimationFrame = window.requestAnimationFrame ||
			    window.mozRequestAnimationFrame ||
			    window.webkitRequestAnimationFrame ||
			    window.msRequestAnimationFrame;	
			    
function orientation(p, q, r, line) {
	var val = (line.segmentY[q] - line.segmentY[p]) *
		  (line.segmentX[r] - line.segmentX[q]) - 
		  (line.segmentX[q] - line.segmentX[p]) *
		  (line.segmentY[r] - line.segmentY[q]);

	if (val == 0) return 0;
	return (val > 0) ? 1:2;
}

function distance(x1, y1, x2, y2) {
	return Math.sqrt(Math.pow(x1 - x2, 2) + Math.pow(y1 - y2, 2));
}

function checkIntersect(i, line, spreadX, spreadY) {
	var o1;
	var o2;
	var o3;
	var o4;
	var angle;

	for (var a = 0; a < i; a++) {
		if (a < i - 2) {
			o1 = orientation(i - 1, i, a, line);
			o2 = orientation(i - 1, i, a + 1, line);
			o3 = orientation(a, a + 1, i - 1, line);
			o4 = orientation(a, a + 1, i, line);
	
			if ((o1 != o2) && (o3 != o4))
				return 0;
		}
	}

	if (i > 1) {
		angle = Math.floor(Math.acos(
				((line.segmentX[i - 1] - line.segmentX[i - 2]) * (line.segmentX[i] - line.segmentX[i - 1]) +
				(line.segmentY[i - 1] - line.segmentY[i - 2]) * (line.segmentY[i] - line.segmentY[i - 1])) /
			       	(Math.sqrt(Math.pow(line.segmentX[i - 1] - line.segmentX[i - 2], 2) +
				 Math.pow(line.segmentY[i - 1] - line.segmentY[i - 2], 2)) *
			 	 Math.sqrt(Math.pow(line.segmentX[i] - line.segmentX[i - 1], 2) +
				 Math.pow(line.segmentY[i] - line.segmentY[i - 1], 2)))
				) / (Math.PI * 2) * 360);
		if (angle > 140 || angle < 40)
			return 0;
	}
	return 1;
}

function validatePoints(i, line, uBoundX, lBoundX, uBoundY, lBoundY) {
	if (line.segmentX[i] > uBoundX)
		line.segmentX[i] = uBoundX - Math.floor((Math.random() + 0.1) * (uBoundX - lBoundX) / 10);
	else if (line.segmentX[i] < lBoundX)
		line.segmentX[i] = lBoundX + Math.floor((Math.random() + 0.1) * (uBoundX - lBoundX) / 10);

	if (line.segmentY[i] > uBoundY)
		line.segmentY[i] = uBoundY - Math.floor((Math.random() + 0.1)* (uBoundY - lBoundY) / 10);
	else if (line.segmentY[i] < lBoundY)
		line.segmentY[i] = lBoundY + Math.floor((Math.random() + 0.1) * (uBoundY - lBoundY) / 10);
}

function generatePoint(spreadX, spreadY, prevX, prevY, i, line, uBX, lBX, uBY, lBY) {
	var minRatio;

	minRatio = 30;
	line.segmentX[i] = Math.floor((Math.random() - 1/2) * spreadX) + prevX;
	line.segmentY[i] = Math.floor((Math.random() - 1/2) * spreadY) + prevY;
	validatePoints(i, line, uBX, lBX, uBY, lBY);

	while ((line.segmentY[i] > prevY - (spreadY / minRatio) && line.segmentY[i] < prevY + (spreadY / minRatio)) ||
	      (line.segmentX[i] > prevX - (spreadX / minRatio) && line.segmentX[i] < prevX + (spreadX / minRatio))) {
		line.segmentX[i] = Math.floor((Math.random() - 1/2) * spreadX) + prevX;
		line.segmentY[i] = Math.floor((Math.random() - 1/2) * spreadY) + prevY;
		validatePoints(i, line, uBX, lBX, uBY, lBY);
	}
}

function generatePoints(endX, endY, segments, line, i, og, uBX, lBX, uBY, lBY) {
	var count;
	var count2;
	var spreadX;
	var spreadY;
	var flag;
	var thresh;
	
	spreadX = Math.floor(distance(line.segmentX[0], line.segmentY[0], endX, endY) / og * 15);
	spreadY = Math.floor(distance(line.segmentX[0], line.segmentY[0], endX, endY) / og * 15);
	flag = 0;
	thresh = 20;

	if (segments == 1) {
		line.segmentX.push(endX);
		line.segmentY.push(endY);
		count = 0;

		while ((checkIntersect(i, line, spreadX, spreadY) == 0 || checkIntersect(i - 1, line, spreadX, spreadY) == 0) &&
			count < thresh) {
			generatePoint(spreadX, spreadY, line.segmentX[i - 2], line.segmentY[i - 2], i - 1, line, uBX, lBX, uBY, lBY);
			count++;
		}
		return (count >= thresh) ? 0:1;
	}
	else {
		count2 = 0;
		while (flag == 0 && count2 < thresh) {
			count = 0;
			generatePoint(spreadX, spreadY, line.segmentX[i - 1], line.segmentY[i - 1], i, line, uBX, lBX, uBY, lBY);

			while (checkIntersect(i, line, spreadX, spreadY) == 0 && count < thresh) {
				generatePoint(spreadX, spreadY, line.segmentX[i - 1], line.segmentY[i - 1], i, line, uBX, lBX, uBY, lBY);
				count++;
			}
			if (count >= thresh)
				return (0);
			else {
				flag = generatePoints(endX, endY, segments - 1, line, i + 1, og, uBX, lBX, uBY, lBY);
				if (flag == 0) {
					line.segmentX.splice(line.segmentX.length - 1);
					line.segmentY.splice(line.segmentY.length - 1);
				}
			}
			count2++;
		}
		return (flag);
	}
}

function generateTriangles(line, scale) {
	var arrayLength = line.segmentX.length * 2 - 1;
	var uSlopeX;
	var uSlopeY;
	var slopeSign;

	slopeSign = 1;
	for (var i = 0; i < arrayLength - 1; i += 2) {
		if (i != 0)
			slopeSign = (orientation(i - 1, i, i + 1, line) == 1) ? 1:-1;
		else
			slopeSign = (orientation(i, i + 1, i + 2, line) == 1) ? 1:-1;
		uSlopeX = (line.segmentX[i] - line.segmentX[i + 1]) * -1 * slopeSign;
		uSlopeY = (line.segmentY[i] - line.segmentY[i + 1]) * slopeSign;
		line.segmentX.splice(i + 1, 0, Math.floor((line.segmentX[i] + line.segmentX[i + 1]) / 2 + (uSlopeY / scale)));
		line.segmentY.splice(i + 1, 0, Math.floor((line.segmentY[i] + line.segmentY[i + 1]) / 2 + (uSlopeX / scale)));
		slopePrev = slopeSign;
	}
}

function generateTriangles2(line, scale) {
	var arrayLength = line.segmentX.length * 2 - 1;
	var uSlopeX;
	var uSlopeY;
	var slopeNext;

	for (var i = 0; i < arrayLength - 1; i += 2) {
		if (i != arrayLength - 2)
			slopeNext = (orientation(i, i + 1, i + 2, line) == 1) ? 1:-1;
		uSlopeX = (line.segmentX[i] - line.segmentX[i + 1]) * -1 * slopeNext;
		uSlopeY = (line.segmentY[i] - line.segmentY[i + 1]) * slopeNext;
		if (distance(line.segmentX[i], line.segmentY[i], line.segmentX[i + 1], line.segmentY[i + 1]) > 100) {
			line.segmentX.splice(i + 1, 0, Math.floor((line.segmentX[i] + line.segmentX[i + 1]) / 2 + (uSlopeY / scale)));
			line.segmentY.splice(i + 1, 0, Math.floor((line.segmentY[i] + line.segmentY[i + 1]) / 2 + (uSlopeX / scale)));
		}
	}
}

function drawLine(line, color, thick, radius) {
	var arrayLength = line.segmentX.length;

	context.strokeStyle = color;
	context.fillStyle = color;
	context.lineWidth = thick;
	for (var i = 1; i < arrayLength; i++) {
		context.beginPath();
		context.arc(line.segmentX[i - 1], line.segmentY[i - 1], radius, Math.PI * 2, false);
		context.fill();
		context.moveTo(line.segmentX[i - 1], line.segmentY[i - 1]);
		context.lineTo(line.segmentX[i], line.segmentY[i]);
		context.stroke();
		context.closePath();
	}
}

function makePoints(line, points, step, count, offX, offY) {
	var arrayLength = line.segmentX.length;
	
	var uX;
	var uY;
	var num;
	var c;

	c = 0;
	for (var i = 0; i < arrayLength; i++) {
		num = Math.floor(distance(line.segmentX[i], line.segmentY[i],
					  line.segmentX[i + 1], line.segmentY[i + 1]) / (count * 3));
		uX = (line.segmentX[i + 1]- line.segmentX[i]) / num;
		uY = (line.segmentY[i + 1]- line.segmentY[i]) / num;
		for (var a = 0; a <= num; a++)
			points.push((new  point(Math.floor(line.segmentX[i] + uX * a + Math.random() * offX),
						Math.floor(line.segmentY[i] + uY * a + Math.random() * offY),
						0, 0)));
	}
}

function drawPoints(points, color, radius) {
	var arrayLength = points.length;

	context.strokeStyle = color;
	context.fillStyle = color;
	for (var i = 0; i < arrayLength; i++) {
		context.beginPath();
		context.moveTo(points[i].X, points[i].Y);
		context.arc(points[i].X, points[i].Y, radius, Math.PI * 2, false);
		context.fill();
		context.stroke();
		context.closePath();
	}
}

var lineSeg1 = {
	segmentX: [canvasW * 3 / 4],
	segmentY: [canvasH / 2]
}
var lineSeg2 = {
	segmentX: [canvasW * 3 / 4],
	segmentY: [canvasH / 2]
}
var lineSeg3 = {
	segmentX: [canvasW * 3 / 4],
	segmentY: [canvasH / 2]
}
var point = function(X, Y) {
	this.X = X;
	this.Y = Y;
};
var points = [];

var segs = 4;
var s = 3;

var sgs = [];
sgs[0] = lineSeg1;
sgs[1] = lineSeg2;
sgs[2] = lineSeg3;

var aLinesX = [];
var aLinesY = [];

function random(lineSeg1, lineSeg2, lineSeg3, sgs, segs, s, points, aLinesX, aLinesY, check) {
	for (var i = 0; i < sgs.length; i++) {
		sgs[i].segmentX.splice(0, sgs[i].segmentX.length);
		sgs[i].segmentY.splice(0, sgs[i].segmentY.length);
		sgs[i].segmentX = [canvasW * 3 / 4];
		sgs[i].segmentY = [canvasW / 2];
	}

	generatePoints(canvasW + 100, canvasH + 100, segs, lineSeg1, 1, segs, canvasW, canvasW * 3 / 4, canvasH, canvasH / 2);
	generatePoints(canvasW + 100, -100, segs, lineSeg2, 1, segs, canvasW + 50, canvasW * 3 / 4, canvasH / 2, 0);
	generatePoints(-50, canvasH / 2, segs * 2, lineSeg3, 1, segs * 2, canvasW * 3 / 4, 0, canvasH, 0);
	
	if (check == 0)
		points.splice(0, points.length);

	for (var i = 0; i < sgs.length; i++) {
		generateTriangles(sgs[i], s * 2);
		for (var k = 0; k < 3; k++)
			generateTriangles2(sgs[i], s * 5);
		if (check == 0)
			makePoints(sgs[i], points, 8, segs * 2, 300, 300);
	}

	aLinesX.splice(0, aLinesX.length);
	aLinesY.splice(0, aLinesY.length);
	for (var i = 0; i < sgs.length; i++) {
		for (var j = 0; j < sgs[i].segmentX.length; j++) {
			aLinesX.push(sgs[i].segmentX[j]);
			aLinesY.push(sgs[i].segmentY[j]);
		}
	}
}

function getMousePos(canvas, evt) {
	var rect = canvas.getBoundingClientRect();
	return {
		X: evt.clientX - rect.left,
		Y: evt.clientY - rect.top
	};
}

canvas.addEventListener('mousemove', function(evt) {
       	mousePos = getMousePos(canvas, evt);
}, false);

canvas.addEventListener('mouseover', function(evt) {
       	pMouse = getMousePos(canvas, evt);
}, false);

var clicked = 0;
canvas.addEventListener('click', function(evt) {
	clicked++;
	if (clicked == 4)
		clicked = 0;
}, false);

var pDist = 0;
var pMouse = {
	X: 0,
	Y: 0
};
var mousePos = {
	X:0,
	Y:0
};
var circle = {
	X: canvasW / 3,
	Y: canvasH / 3,
	r: 300
}
var ramp = 0;
function animate() {
	var arrayLength = points.length;
	var speed;
	var spt;
	var dX;
	var dY;
	var dist;
	
	context.clearRect(0, 0, canvasW, canvasH);
	context.fillStyle = "black";
	context.fillRect(0, 0, canvasW, canvasH);
	if (clicked == 2 || clicked == 3) {
		for (var j = 0; j < sgs.length; j++)
			drawLine(sgs[j], "#CCC", 4, 4);
	}
	if (clicked == 1 || clicked == 3)
		drawPoints(points, "rgba(200, 200, 200, 200)", 2);
	context.lineWidth = 1;
	spt = 0;
	pDist = distance(mousePos.X, mousePos.Y, pMouse.X, pMouse.Y);
	speed = 0.028 / (1 + pDist);
	pMouse = mousePos;
	
	color = "rgba(170,170,170,200)";
	for (var i = 0; i < arrayLength; i++) {
		dX = aLinesX[spt] - points[i].X;
		dY = aLinesY[spt] - points[i].Y;
		points[i].X += dX * speed;
		points[i].Y += dY * speed;
		spt = (spt == aLinesX.length ? 0:spt + 1);
		context.strokeStyle = color;
		context.fillStyle = color;
		/*
		if (distance(points[i].X, points[i].Y, circle.X, circle.Y) < circle.r) {
			if (distance(points[i].X, points[i].Y, circle.X, circle.Y) < circle.r - 200) {
				points[i].X = circle.X + circle.r;
				points[i].Y = circle.Y + circle.r;
			}
			else {
				points[i].X -= dX * 0.03;
				points[i].Y -= dY * 0.03;
			}
		}
		*/
		for (var a = 0; a < arrayLength; a++) {
			dist = distance(points[i].X, points[i].Y, points[a].X, points[a].Y);
			if (i > a && dist < 180) {
				context.beginPath();
				context.moveTo(points[i].X, points[i].Y);
				context.lineTo(points[a].X, points[a].Y);
				context.stroke();
				context.closePath();
			}
			if (i != a && dist < 80) {
				points[i].X -= (ramp + 0.02) * (Math.pow(pDist + 1, 1)) * Math.pow(dX, -1);
				points[i].Y -= (ramp + 0.02) * (Math.pow(pDist + 1, 1)) * Math.pow(dY, -1);
				points[a].X += 0.0001 * -dX;
				points[a].Y += 0.0001 * -dY;
			}
		}
	}
	ramp += (pDist == 0 ? 0.1:-0.1);
	ramp = (ramp > 15 ? 15:ramp);
	ramp = (ramp < -1 ? -1:ramp);
	if (ramp == 15) {
		random(lineSeg1, lineSeg2, lineSeg3, sgs, segs, s, points, aLinesX, aLinesY, 1);
		ramp = 0;
	}
	//context.moveTo(circle.X + circle.r, circle.Y);
	//context.arc(circle.X, circle.Y, circle.r - 80, Math.PI * 2, false);
	//context.fillStyle = "#000000";
	//context.strokeStyle = "#000000";
	//context.stroke();
	//context.fill();
	//context.fillStyle = "rgba(100,100,100,100)";
	//context.strokeStyle = "rgba(100,100,100,100)";
	//context.font = "50px Arial";
	//context.fillText("Placeholder", circle.X - circle.r + 175, circle.Y);
	requestAnimationFrame(animate);
}

random(lineSeg1, lineSeg2, lineSeg3, sgs, segs, s, points, aLinesX, aLinesY, 0);
animate();
