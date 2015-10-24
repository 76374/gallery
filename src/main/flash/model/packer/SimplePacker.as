package model.packer
{
	import flash.geom.Rectangle;
	/**
	 * Simple packer from https://github.com/jakesgordon/bin-packing/blob/master/js/packer.js
	 * + Added rect sorting for better results.
	 * + Added rect that don't fit (as result after packing)
	 * + Added space between rects
	 */	
	public class SimplePacker implements IRectPacker
	{
		private var root : Object;
		
		public function SimplePacker()
		{
		}
		
		public function pack(rects : Vector.<Rectangle>, w : Number, h : Number, space : Number) : Vector.<Rectangle>
		{
			this.root = { x: 0, y: 0, w: w + space, h: h + space};
			
			var sortedRects : Vector.<Rectangle> = rects.slice().sort(sortHandler);
			var blocks : Array = [];
			for each(var rect : Rectangle in sortedRects)
			{
				blocks.push({w : rect.width + space, h : rect.height + space});
			}
			fit(blocks);
			
			var extraRects : Vector.<Rectangle>;
			for (var i : int = 0; i < sortedRects.length; i++)
			{
				if (blocks[i].fit)
				{
					sortedRects[i].x = blocks[i].fit.x;
					sortedRects[i].y = blocks[i].fit.y;
				}
				else
				{
					if (!extraRects)
					{
						extraRects = new Vector.<Rectangle>();
					}
					extraRects.push(sortedRects[i]);
				}
			}
			
			return extraRects;
		}
		
		private function sortHandler(rect1 : Rectangle, rect2 : Rectangle) : Number
		{
			return Math.max(rect2.height) - Math.max(rect1.height);
		}
		
		private function fit(blocks : Array) : void
		{
			var n : int;
			var node : Object;
			var block : Object;
			for (n = 0; n < blocks.length; n++) {
				block = blocks[n];
				node = this.findNode(this.root, block.w, block.h)
				if (node)
					block.fit = this.splitNode(node, block.w, block.h);
			}
		}
		
		private function findNode(root : Object, w : Number, h : Number) : Object {
			if (root.used)
				return this.findNode(root.right, w, h) || this.findNode(root.down, w, h);
			else if ((w <= root.w) && (h <= root.h))
				return root;
			else
				return null;
		}
		
		
		private function splitNode(node : Object, w : Number, h : Number) : Object
		{
			node.used = true;
			node.down  = { x: node.x,     y: node.y + h, w: node.w,     h: node.h - h };
			node.right = { x: node.x + w, y: node.y,     w: node.w - w, h: h          };
			return node;
		}
	}
}