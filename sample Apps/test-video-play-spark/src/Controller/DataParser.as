package Controller
{
	import avmplus.USE_ITRAITS;
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.globalization.NumberFormatter;
	
	import model.DataEntity;
	
	import mx.collections.ArrayCollection;
	import mx.core.mx_internal;
	
	import spark.formatters.NumberFormatter;
	
	public class DataParser
	{
		
		private var baseFolder:String = "";
		private var relativeXmlFilePath:String = "";
		private var relativeContentFolderPath:String = "";
		private var relativeResourceFolderPath:String = "";
		
		public function DataParser(_baseFolder:String, xmlPath:String, contentFolder:String, resourcePath:String)
		{
			baseFolder = _baseFolder;
			relativeXmlFilePath = xmlPath;
			relativeContentFolderPath = contentFolder;
			relativeResourceFolderPath = resourcePath;
			
		}
		
		public function populateDataEntityFromXml(inDataEntityCollection:ArrayCollection):Boolean
		{
			
			var file:File = File.applicationDirectory;
			file = file.resolvePath(baseFolder + relativeXmlFilePath);
			
			var fileStream:FileStream = new FileStream();
			fileStream.open(file, FileMode.READ);
			
			var inXml:XML = XML(fileStream.readUTFBytes(fileStream.bytesAvailable));
			
			var contents:XMLList = inXml.Content;
			for(var i:int = 0; i < contents.length(); i++)
			{
				var _dataEntity:DataEntity = new DataEntity;
			
				_dataEntity.name = contents[i].name.toString();
				
				if(contents[i].icon != null && contents[i].icon.toString() != "")
					_dataEntity.icon1 = baseFolder + relativeResourceFolderPath + contents[i].icon.toString();
				
				_dataEntity.completeContentPath = baseFolder + relativeContentFolderPath + contents[i].relativeSrcfile;
				inDataEntityCollection.addItem(_dataEntity);
			}
			
			return true;
			
		}
		
	}
	
}