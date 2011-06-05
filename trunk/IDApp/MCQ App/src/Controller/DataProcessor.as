package Controller
{
	import model.QuestionsProxy;
	

	public class DataProcessor
	{
		private static var _instance:DataProcessor = new DataProcessor(SingletonLock);
		
		private var _quesProxy:QuestionsProxy;

		public function DataProcessor(lock:Class)
		{
			//TODO: make a check on lock variable: 
			//http://www.darronschall.com/weblog/2007/11/actionscript-3-singleton-redux.cfm
			_quesProxy = new QuestionsProxy();
			
		}
		
		public static function get instance():DataProcessor
		{
			return _instance;
		}
		
		public function get quesProxy():QuestionsProxy
		{
			return _quesProxy;
		}

	}
}

class SingletonLock
{
} // end class

