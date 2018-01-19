
var images = {
	"Ceramics":"Images/materials.png",
	"Sketching":"Images/wave.jpg",
	"3D Modeling":"Images/lamp_render_improved.png",
	"Unity":"Images/materials.png",
	"Processing":"Images/circleFractal.png",
	"HTML/CSS":"Images/stars.jpg"
};
var imgA = {};
imgA["Ceramics"] = [];
imgA["Sketching"] = [];
imgA["3D Modeling"] = ["Images/BowlingAlley.jpg", "Images/BowlingBall.jpg", "Images/BowlingPin.jpg", "Images/ChessBoardRendered.jpg", "Images/ChessBoardUnrendered.jpg", "Images/lamp_render_improved.png",  "Images/Lamp_Unrendered.png", "Images/Pyramid.jpg"];
imgA["Unity"] = ["Images/editor_interface.jpg", "Images/asset_management.png", "Images/project_management.png", "Images/materials.png", "Images/programming.png", "Images/physics.png", "Images/UI.png", "Images/audio.png", "Images/lightning.png", "Images/animation.png"];
imgA["Processing"] = ["Images/mona.jpg", "Images/stars.jpg", "Images/wave.jpg", "Images/ballBounce.png", "Images/ballFollow.png", "Images/branches.png", "Images/circleFractal.png", "Images/edge.png", "Images/gui.png", "Images/koch.png", "Images/physicsSim.png", "Images/sharpen.png"];
var scriptA = {};
scriptA["Ceramics"] = [];
scriptA["Sketching"] = [];
scriptA["3D Modeling"] = ["Images/BowlingAlley.jpg", "Images/BowlingBall.jpg", "Images/BowlingPin.jpg", "Images/ChessBoardRendered.jpg", "Images/ChessBoardUnrendered.jpg", "Images/lamp_render_improved.png", "Images/Lamp_Unrendered.png", "Images/Pyramid.jpg"];
scriptA["Unity"] = ["Images/editor_interface.jpg", "Images/asset_management.png", "Images/project_management.png", "Images/materials.png", "Images/programming.png", "Images/physics.png", "Images/UI.png", "Images/audio.png", "Images/lightning.png", "Images/animation.png"];
scriptA["Processing"] = ["processing/oil.pde", "processing/sketch.pde", "processing/layers.pde"];
scriptA["HTML/CSS"] = [];
var titleA = {};
titleA["Ceramics"] = [];
titleA["Sketching"] = [];
titleA["3D Modeling"] = ["Bowling Alley", "Bowling Ball", "Bowling Pin", "Chess Board Rendered", "Chess Board", "Lamp Render Improved", "Lamp Unrendered", "Pyramid"];
titleA["Unity"] = ["Editor Interface", "Asset Management", "Project Management", "Materials", "Programming", "Physics", "UI", "Audio", "Lighting", "Animation"];
titleA["Processing"] = ["Brush", "Sketch", "Dots", "Bouncing Balls", "Following Balls", "Branch Fractal", "Circle Fractal", "Edge Detection", "Simple GUI", "Koch Curve", "Simple Physics Sim", "Sharpen"];
titleA["HTML/CSS"] = [];
var textA = {};
textA["Ceramics"] = [];
textA["Sketching"] = [];
textA["3D Modeling"] = [
	"The fundamentals of setting a scene in Blender - positioning elements and working the camera.",
	"An exercise in sphere types and extrusion in Blender.",
	"The use of Bezier curves to create organic shapes.",
	"Showcasing several diffrent materials in Blender. There is a quartz pattern on the board, a reflective sheen on the pieces and a wooden texture to the edges.",
	"Creating a scene and low-poli modeling in Blender. Each piece was modeled by the sides of a cylinder in or out based on an overlayed refrence image.",
	"Lighting in Blender, including reflections, diffusion and shadow.",
	"The creation of the texture of the lamp, including reflections, texture and coloring.",
	"Basic modeling - cutting and extruding faces."];
textA["Unity"] = [
	"Learning the basics of the Unity Editor.",
	"Learning how to import, manage and use assets.",
	"Learning how to put together and keep track of an Unity project.",
	"Learning how to texture and color objects.",
	"Learning how to program in C#.",
	"Learning how to implement physics - gravity and collisions.",
	"Learning how to build an user interface.",
	"Learning how to import and manipulate audio.",
	"Learning how to manipulate and create diffrent types of light.",
	"Learning how to animate models."];
textA["Processing"] = [
	"Combines brush like strokes and dots to paint a source image.",
	"Uses crosshatching to crate and monochrome version of a source image.",
	"Creates a source image using a series of dots animated by a vector field.",
	"A simple bouncing ball.",
	"A series of balls that accelerate towards the mouse.",
	"A simple branching fractal.",
	"A fractal made by drawing increasingly smaller circles around each circle.",
	"Simple edge detection using diffrence in color and luminosity.",
	"A simple dynamic GUI mockup.",
	"The Koch Curve fractal.",
	"A simple physics simulator that takes into account friction, gravity and wind.",
	"Sharpening algorithim that modifies each pixels color to increase contrast within the selected area."];
textA["HTML/CSS"] = [];

function Point(L, T, R, B, D) {
	this.L = L;
	this.T = T;
	this.R = R;
	this.B = B;
	this.dir = [0, 0, 0, 0];
	if (D != -1)
		this.dir[D] = 1;
};

function moveFlush(slide) {
	var gap = 25;
	var points = [];
	var intersect = true;
	if (slide == 0) {
		var gridImagesN = $("#slide-1C .gridImage:not(.saver)");
		var gridImages = $("#slide-1C .gridImage");
		points.push(new Point($("#slide-1C .saver").offset().left,
					$("#slide-1C .saver").offset().top,
					$("#slide-1C .saver").offset().left + $("#slide-1C .saver").width(),
					$("#slide-1C .saver").offset().top + $("#slide-1C .saver").height(),
					-1));
	}
	else {
		var gridImagesN = $("#slide1C .gridImage:not(.saver)");
		var gridImages = $("#slide1C .gridImage");
		points.push(new Point($("#slide1C .saver").offset().left,
					$("#slide1C .saver").offset().top,
					$("#slide1C .saver").offset().left + $("#slide1C .saver").width(),
					$("#slide1C .saver").offset().top + $("#slide1C .saver").height(),
					-1));
	}
	$(gridImagesN).each(function() {
		$(this).removeClass("placed");;
	});
	$(gridImagesN).each(function() {
		intersect = true;
		if (Math.random() > 0.5) {
			$(this).removeClass("gallery");
			$(this).addClass("gallery2");
		}
		else {
			$(this).removeClass("gallery2");
			$(this).addClass("gallery");
		}
		while (intersect) {
			var cur = points[Math.floor(Math.random() * points.length)];
			var rand = Math.floor(Math.random() * 8);
			while (cur.dir[Math.floor(rand / 2)] != 0)
				rand = Math.floor(Math.random() * 8);
			cur.dir[Math.floor(rand / 2)] = 1;
			if ($.inArray(0, cur.dir) == -1)
				points.splice(points.indexOf(cur), 1);
			var tX;
			var tY;
			switch (rand) {
				case 0:
				case 1:
					tX = cur.L - $(this).data("X") - $(this).width() - gap;
					if (rand == 0) 
						tY = cur.T - $(this).data("Y");
					else
						tY = cur.B - ($(this).data("Y") + $(this).height());
					var bck = 2;
					break;
				case 2:
				case 3:
					if (rand == 2)
						tX = cur.L - $(this).data("X");
					else
						tX = cur.R - ($(this).data("X") + $(this).width());
					tY = cur.T - $(this).data("Y") - $(this).height() - gap;
					var bck = 3;
					break;
				case 4:
				case 5:
					tX = cur.R - $(this).data("X") + gap;
					if (rand == 4) 
						tY = cur.T - $(this).data("Y");
					else
						tY = cur.B - ($(this).data("Y") + $(this).height());
					var bck = 0;
					break;
				case 6:
				case 7:
					if (rand == 6)
						tX = cur.L - $(this).data("X");
					else
						tX = cur.R - ($(this).data("X") + $(this).width());
					tY = cur.B - $(this).data("Y") + gap;
					var bck = 1;
					break;
			}
			tX = Math.floor(tX);
			tY = Math.floor(tY);
			var img = $(this);
			intersect = false;
			$(".placed").each(function () {
				if ($(img).data("X") + tX > $(this).offset().left + $(this).width() || $(this).offset().left > $(img).data("X") + tX + $(img).width()) {}
				else if ($(img).data("Y") + tY > $(this).offset().top + $(this).height() || $(this).offset().top > $(img).data("Y") + tY + $(img).height()) {} 
				else
					intersect = true;

				if ($(img).data("X") + tX > $(window).width() * 7.5 / 10 || $(img).data("X") + tX < $(window).width() / 10 * 2.5)
					intersect = true;
				else if ($(img).data("Y") + tY + $(img).height() > $(window).height() - gap || $(img).data("Y") + tY < gap)
					intersect = true;
			});
		}
		$(this).css({"transform":"translate(" + tX + "px," + tY + "px)"});
		$(this).addClass("placed");
		points.push(new Point($(this).offset().left,
					$(this).offset().top,
					$(this).offset().left + $(this).width(),
					$(this).offset().top + $(this).height(),
					bck));
	});
}
var dataText;
$(".menuButton").mouseenter(function() {
	dataText = $(this).attr("data-id");
	if ($(this).parents(".container").find(".displayHead").text() != dataText) {
		$(this).parents(".container").find(".displayText").fadeTo(500, 0).fadeTo(700, 1);
		$(this).parents(".container").find(".displayHead").fadeTo(500, 0, function () {
			$(this).text(dataText);
		}).fadeTo(700, 1);
		$(this).parents(".container").find(".displayPara").fadeTo(500, 0);
		$(this).parents(".container").find(".gridImage").fadeTo(500, 0, function () {
			$(this).filter(".saver").css("background", "transparent url(\"" + images[dataText] + "\") no-repeat center");
			//$(this).filter(".saver").css("background", "url(\"" + images[dataText] + "\") center / contain no-repeat transparent");
			$(this).filter(".saver").removeClass("gallery");
			$(this).filter(".saver").addClass("display");
		}).parents(".container").find(".saver").fadeTo(700, 1);
		$(this).parents(".container").find("#activeButton").removeAttr("id");
		$(this).parent().attr("id", "activeButton");
	}
});
$(".menuButton").click(function() {
	dataText = $(this).attr("data-id");
	if ($(this).parents(".container").find(".saver").hasClass("display")) {
		$(this).parents(".container").find(".displayText").fadeTo(700, 0);
		$(this).parents(".container").find(".saver").filter(function() {
			$(this).removeClass("display");
			$(this).addClass("gallery");
			var cur = $(this).parents(".container").find(".gridImage");
			$.each(imgA[dataText], function(index, data) {
				var text = data;
				$(cur).not(".saver").each(function() {
					if (!($(this).hasClass("set"))) {
						$(this).css("object-position",  "");
						$(this).css("background", "transparent url(\"" + text + "\") no-repeat center");
						$(this).attr("data-before", titleA[dataText][imgA[dataText].indexOf(text)]);
						$(this).attr("data-index", imgA[dataText].indexOf(text));
						$(this).attr("data-text", scriptA[dataText][$(this).data("index")]);
						$(this).removeClass("off");
						$(this).addClass("set");
						return false;
					}
				});
			});
			$(cur).not(".saver").each(function() {
				if (!($(this).hasClass("set"))) {
					$(this).css("background", "grey");
					$(this).css("object-position",  "-99999px 99999px");
					$(this).attr("data-before", "");
					$(this).attr("data-text", "");
					$(this).attr("data-index", "");
					$(this).addClass("off");
				}
				$(this).removeClass("set");
			});
			$(this).one("webkitTransitionEnd otransitionend oTransitionEnd msTransitionEnd transitionend", function() {
				if ($(this).parents(".container").attr("id") == "slide-1C")
					moveFlush(0);
				else
					moveFlush(1);
				$(this).parents(".container").find(".gridImage:not(.saver)").fadeTo(200, 1);
			});
		});
	}
	else if ($(this).parents(".container").find(".saver").hasClass("gallery")) {
		$(this).parents(".container").find(".displayText").fadeTo(700, 1);
		$(this).parents(".container").find(".gridImage:not(.saver)").fadeTo(400, 0).delay(300).parents(".container").find(".saver").filter(function() {
			$(".saver").removeClass("gallery");
			$(".saver").addClass("display");
		});
	}
});
var isDisplayL = false;
$("#slide-1C .gridImage").click(function () {
	if ($(this).hasClass("display") && $(this).css("opacity") == 1 && isDisplayL) {
		$(this).removeClass("display");
		$(this).addClass("gallery");
		$(this).parents(".container").find(".gridImage:not(.saver)").delay(500).fadeTo(200, 1);
		$(this).parents(".container").find(".displayText").fadeTo(700, 0);
		isDisplayL = false;
	}
	else if (($(this).hasClass("gallery") || $(this).hasClass("gallery2")) && $(this).css("opacity") == 1 && !isDisplayL && !($(this).hasClass("off"))) {
		var cur = $(this);
		$(this).parents(".container").find(".gridImage").fadeTo(400, 0, function() {
			$(this).filter(".saver").css("background", $(cur).css("background"));
			$(this).filter(".saver").css("background-size", "auto");
			$(this).filter(".saver").removeClass("gallery");
			$(this).filter(".saver").addClass("display");
		}).filter(".saver").fadeTo(700, 1);
		$(this).parents(".container").find(".displayHead").text($(cur).data("before"));
		$(this).parents(".container").find(".displayPara").text(textA[dataText][$(cur).data("index")]);
		$(this).parents(".container").find(".displayText").delay(400).fadeTo(700, 1);
		$(this).parents(".container").find(".displayPara").delay(400).fadeTo(700, 1);;
		isDisplayL = true;
	}
});
var isDisplayR = false;
$("#slide1C .gridImage").click(function () {
	if ($(this).hasClass("display") && $(this).css("opacity") == 1 && isDisplayR) {
		$(this).removeClass("display");
		$(this).addClass("gallery");
		$(this).parents(".container").find(".gridImage:not(.saver)").delay(500).fadeTo(200, 1);
		$(this).parents(".container").find(".displayText").fadeTo(700, 0);
		isDisplayR = false;
	}
	else if (($(this).hasClass("gallery") || $(this).hasClass("gallery2")) && $(this).css("opacity") == 1 && !isDisplayR && !($(this).hasClass("off"))) {
		var cur = $(this);
		$(this).parents(".container").find(".gridImage").fadeTo(400, 0, function() {
			$(this).filter(".saver").css("background", $(cur).css("background"));
			$(this).filter(".saver").removeClass("gallery");
			$(this).filter(".saver").addClass("display");
			/*
			if (dataText == "Processing") {
				var text = $(cur).data("text");
				$(cur).css("background", "transparent");
				var processingInstance = document.getElementById("canvas1");
				Processing.loadSketchFromSources(processingInstance, [text]);
			}
			*/
		}).filter(".saver").fadeTo(700, 1);
		$(this).parents(".container").find(".displayHead").text($(cur).data("before"));
		$(this).parents(".container").find(".displayPara").text(textA[dataText][$(cur).data("index")]);
		$(this).parents(".container").find(".displayText").delay(400).fadeTo(700, 1);
		$(this).parents(".container").find(".displayPara").delay(400).fadeTo(700, 1);;
		isDisplayR = true;
	}
});
$("#hs0L").click(function(){ $.fn.fullpage.moveSlideLeft(); });
$("#hs1L").click(function(){ $.fn.fullpage.moveSlideLeft(); });
$("#hs0R").click(function(){ $.fn.fullpage.moveSlideRight(); });
$("#hs-1R").click(function(){ $.fn.fullpage.moveSlideRight(); });
$("#hs0B").click(function(){ $.fn.fullpage.moveSectionDown(); });
$("#aT").click(function(){ $.fn.fullpage.moveSectionUp(); });

