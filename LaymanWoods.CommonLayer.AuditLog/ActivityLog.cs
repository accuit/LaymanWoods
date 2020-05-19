using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using log4net;

namespace LaymanWoods.CommonLayer.Log
{
    public class ActivityLog
    {
        private static readonly ILog logger = log4net.LogManager.GetLogger("LaymanWoods");
        public static void SetLog(string message, LogLoc location)
        {

            switch (location)
            {
                case LogLoc.ERROR:
                    logger.Error(message);
                    break;
                case LogLoc.DEBUG:
                    logger.Debug(message);
                    break;
                case LogLoc.INFO:
                    logger.Info(message);
                    break;
                default:
                    logger.Debug(message);
                    break;
            }
        }
    }
}
