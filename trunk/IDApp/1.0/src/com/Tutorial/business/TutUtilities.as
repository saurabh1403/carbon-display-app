package com.Tutorial.business
{
	import com.Tutorial.ApplicationFacade;
	import com.Tutorial.model.PackageProxy;
	import com.Tutorial.model.objects.Chapter;
	import com.Tutorial.model.objects.DataEntity;
	import com.Tutorial.model.objects.Package;
	import com.Tutorial.model.objects.Section;
	import com.Tutorial.model.objects.SubTopic;
	import com.Tutorial.model.objects.Topic;
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import mx.collections.ArrayCollection;
	import mx.utils.StringUtil;

	public class TutUtilities
	{
		//<TODO : Need to modify the logic used in this function later on>
		public static function readFile(path:String):String
		{
			//<TODO : Need to modify this logic later on>
			/*var file:File = new File();
			
			trace(File.applicationDirectory.nativePath);
			
			file = File.applicationDirectory.resolvePath(path);
			//file = File.applicationDirectory.resolvePath("\\assets\\data\\getAllPkg.xml");
			//file.resolvePath(path);
			
			trace(file.nativePath);*/
			
			var file:File = new File (File.applicationDirectory.nativePath + path);
			trace(file.nativePath);
			
			if(!file.exists)
				return "";
			
			var stream:FileStream = new FileStream();
			stream.open(file, FileMode.READ);
			return stream.readUTFBytes(stream.bytesAvailable);
		}
		
		private static function findProperSubElements(xml:XML):XMLList
		{
			if(xml.child("headings").length() != 0)
			{
				return xml.headings.heading as XMLList;
			}
			else if(xml.child("topics").length() != 0)
			{
				return xml.topics.topic as XMLList;
			}
			else if(xml.child("subtopics").length() != 0)
			{
				return xml.subtopics.subtopic as XMLList;
			}
			else
			{
				return null;
			}
		}
		
		public static function populateStructures(arrC:ArrayCollection, xml:XML, bConsiderLevel1:Boolean = true):void
		{
			//3 level : section
			//2 level : chapter
			//1 level : topic
			//0 level : subtopic
			
			var xmlList:XMLList = null;
			
			var ent:DataEntity = new DataEntity;
			
			if(xml.child("name").length() != 0)
				ent.name = xml.name;
			
			if(xml.child("relativeSrcfile").length() != 0)
				ent.relativeSrcFile = xml.relativeSrcfile;
			if(xml.child("duration").length() != 0)
				ent.duration = xml.duration;
			if(xml.child("keywords").length() != 0)
				ent.keywords = xml.keywords;
			if(xml.child("type").length() != 0)
			{
				var index:int = xml.type.toString().lastIndexOf(".");
				if(index == -1)
				{
					trace("invalid source file specified");
				}
				switch(xml.type.toString().substr(index+1).toLowerCase())
				{
					case "flv":
						ent.videoType = TutConstants.CONTENT_FLV;
						break;
					case "swf":
						ent.videoType = TutConstants.CONTENT_SWF;
						break;
					case "pdf":
						ent.videoType = TutConstants.CONTENT_PDF;
						break;
					case "htm":
					case "html":
						ent.videoType = TutConstants.CONTENT_HTM;
						break;
				}
			}
			
			ent.subTopics = null;
			
			var iLevel:int = findContentLevel(xml);
			
			xmlList = findProperSubElements(xml);
			if(xmlList == null)
			{
				ent.children = null;
			}
			else
			{
				for(var i:int = 0; i < xmlList.length(); ++i)
				{
					populateStructures(ent.children, xmlList[i], (!bConsiderLevel1 || (iLevel == 3)) ? false : true);
				}
			}
			
			switch(iLevel)
			{
				case 4:
					//nothing to be handled here as of now.....
					break;
				case 3:
					
					ent.contentType = TutConstants.LEVELCONTENT3;
					
					break;
				case 2:
					
					ent.contentType = TutConstants.LEVELCONTENT2;
					
					break;
				case 1:
					
					ent.contentType = TutConstants.LEVELCONTENT1;
					
					if(!bConsiderLevel1)
					{
						ent.children = null;
						ent.subTopics = new ArrayCollection;
						
						for(var j:int = 0; j < xmlList.length(); ++j)
						{
							populateStructures(ent.subTopics, xmlList[j]);
						}
					}
					
					break;
				case 0:
					
					ent.contentType = TutConstants.LEVELCONTENT0;
					ent.children = null;
					ent.subTopics = null;
					
					break;
				default:
					break;
			}
			arrC.addItem(ent);
		}
		//function to form hierarchical data structures for us
		public static function populateStructures1(arrC:ArrayCollection, xml:XML):void
		{
			//3 level : section
			//2 level : chapter
			//1 level : topic
			//0 level : subtopic
			
			var xmlList:XMLList = null;
			
			var iLevel:int = findContentLevel(xml);
			switch(iLevel)
			{
				case 4:
					break;
				case 3:
					var section:Section = new Section;
					
					section.name = xml.name;
					section.contentType = TutConstants.LEVELCONTENT3;
					
					xmlList = findProperSubElements(xml);
					if(xmlList != null)
					{
						for(var i:int = 0; i < xmlList.length(); ++i)
						{
							populateStructures(section.children, xmlList[i]);
						}
					}
					
					/*for(var j:int = 0; j < xml.topics.topics.length(); ++j)
					{
						populateStructures(chapter.children, xml.headings.heading[j]);
					}*/
					
					arrC.addItem(section);
					
					break;
				case 2:
					var chapter:Chapter = new Chapter;
					
					chapter.name = xml.name;
					chapter.contentType = TutConstants.LEVELCONTENT2;
					
					xmlList = findProperSubElements(xml);
					if(xmlList != null)
					{
						for(var j:int = 0; j < xmlList.length(); ++j)
						{
							populateStructures(chapter.children, xmlList[j]);
						}
					}
					
					/*for(var j:int = 0; j < xml.topics.topics.length(); ++j)
					{
						populateStructures(chapter.children, xml.topics.topic[j]);
					}*/
					
					arrC.addItem(chapter);
					break;
				case 1:
					var topic:Topic = new Topic;
					
					topic.name = xml.name;
					topic.contentType = TutConstants.LEVELCONTENT1;
					
					xmlList = findProperSubElements(xml);
					if(xmlList != null)
					{
						for(var k:int = 0; k < xmlList.length(); ++k)
						{
							populateStructures(topic.children, xmlList[k]);
						}
					}
					
					/*for(var k:int = 0; k < xml.subtopics.subtopic.length(); ++k)
					{
						populateStructures(topic.children, xml.subtopics.subtopic[k]);
					}*/
					
					arrC.addItem(topic);
					break;
				case 0:
					var subTopic:SubTopic = new SubTopic;
					
					subTopic.name = xml.name;
					subTopic.contentType = TutConstants.LEVELCONTENT0;
					subTopic.relativeSrcFile = xml.relativeSrcfile;
					subTopic.duration = xml.duration;
					subTopic.keywords = xml.keywords;
					
					var index:int = subTopic.relativeSrcFile.lastIndexOf(".");
					if(index == -1)
					{
						trace("invalid source file specified");
					}
					
					switch(subTopic.relativeSrcFile.substr(index+1).toLowerCase())
					{
						case "flv":
							subTopic.videoType = TutConstants.CONTENT_FLV;
							break;
						case "swf":
							subTopic.videoType = TutConstants.CONTENT_SWF;
							break;
						case "pdf":
							subTopic.videoType = TutConstants.CONTENT_PDF;
							break;
						case "htm":
						case "html":
							subTopic.videoType = TutConstants.CONTENT_HTM;
							break;
					}
										
					arrC.addItem(subTopic);
					break;
				default:
					trace("invalid content level found");
					break;
			}
		}
		public static function populateSessionDataInProxy(sXML:XML):void
		{
			var sessionID:String = sXML.@id;
			trace("sessionID : " + sessionID);
			
			var proxy:PackageProxy = ApplicationFacade.getInstance().retrieveProxy(PackageProxy.NAME) as PackageProxy;
			var pkg:Package = proxy.getPkgOfSession(sessionID);
			if(pkg == null)
			{
				trace("unable to retrieve proper package details for the session : " + sessionID);
				return;
			}
			
			//populate data for explainationData
			try{
				var path1:String = sXML.outputXml.contentNodes.explainationData.infoXmlPath;
				var content1:String = readFile(path1);
				
				if(content1 != "")
				{
					populateStructures(pkg.children, new XML(content1));
				}
				else
				{
					trace("unable to read content for explainationData for session : " + sessionID);
				}
			}
			catch(err:Error)
			{
				trace("Exception occurred in populateSessionDataInProxy");
				//return false;
			}
			//populate data for exerciseQuestions
			try{
				var path2:String = sXML.outputXml.contentNodes.exerciseQuestions.infoXmlPath;
				var content2:String = readFile(path2);
				
				if(content2 != "")
				{
					populateStructures(pkg.children, new XML(content2));
				}
				else
				{
					trace("unable to read content for exerciseQuestions for session : " + sessionID);
				}
			}
			catch(err:Error)
			{
				trace("Exception occurred in populateSessionDataInProxy");
				//return false;
			}
			//populate data for extraQuestions
			try{
				var path3:String = sXML.outputXml.contentNodes.extraQuestions.infoXmlPath;
				var content3:String = readFile(path3);
				
				if(content3 != "")
				{
					populateStructures(pkg.children, new XML(content3));
				}
				else
				{
					trace("unable to read content for extraQuestions for session : " + sessionID);
				}
			}
			catch(err:Error)
			{
				trace("Exception occurred in populateSessionDataInProxy");
				//return false;
			}
			//populate data for practiseQuestions
			try{
				var path4:String = sXML.outputXml.contentNodes.practiseQuestions.infoXmlPath;
				var content4:String = readFile(path4);
				
				if(content4 != "")
				{
					populateStructures(pkg.children, new XML(content4));
				}
				else
				{
					trace("unable to read content for practiseQuestions for session : " + sessionID);
				}
			}
			catch(err:Error)
			{
				trace("Exception occurred in populateSessionDataInProxy");
				//return false;
			}
			
			pkg.bAlreadyPopulated = true;
		}
		
		public static function findContentLevel(xml:XML):int
		{
			var level:int = 0;
			
			try
			{
				var str:String = xml.contentType.toString();
				level = Number(str);
				if(isNaN(level))
					level = 0;
			}
			catch(er:Error){}
			
			return level;
			
			
			/*var lvl:int = 0;
			try{
				if(xml.contents.content.length() != 0)
					lvl = 1 + findContentLevel(xml.contents.content[0]);
			}
			catch(err:Error){}
			
			return lvl;*/
		}
	}
}