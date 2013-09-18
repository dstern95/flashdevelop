using System;
using System.Collections.Generic;
using System.Text;

namespace FlashDebugger.Debugger.HxCpp.Server
{
    class StringList
    {
        public static StringList FromEnum(HaxeEnum haxeEnum)
        {
            if (haxeEnum.name != "debugger.StringList") { throw new InvalidCastException("Trying to case HaxeEnum "+haxeEnum.name+" to debugger.Message"); }
            if (haxeEnum.constructor == "Terminator") {
                Terminator ret = new Terminator();
                return ret;
            }
            if (haxeEnum.constructor == "Element") {
                Element ret = new Element();
                ret.string_ = (string)haxeEnum.arguments[0];
                ret.next = StringList.FromEnum((HaxeEnum)haxeEnum.arguments[1]);
                return ret;
            }
            throw new InvalidCastException("Unknown constructor "+haxeEnum.constructor+" for HaxeEnum "+haxeEnum.name);
        }

        public class Terminator : StringList
        {
            public override string ToString()
            {
                return "[StringList.Terminator()]";
            }
        }

        public class Element : StringList
        {
            public string string_ { get; set; }
            public StringList next { get; set; }
            public override string ToString()
            {
                return "[StringList.Element(string=" + string_ + ", next=" + next + ")]";
            }
        }

    }

    class BreakpointList
    {
        public static BreakpointList FromEnum(HaxeEnum haxeEnum)
        {
            if (haxeEnum.name != "debugger.BreakpointList") { throw new InvalidCastException("Trying to case HaxeEnum "+haxeEnum.name+" to debugger.Message"); }
            if (haxeEnum.constructor == "Terminator") {
                Terminator ret = new Terminator();
                return ret;
            }
            if (haxeEnum.constructor == "Breakpoint") {
                Breakpoint ret = new Breakpoint();
                ret.number = (int)haxeEnum.arguments[0];
                ret.description = (string)haxeEnum.arguments[1];
                ret.enabled = (bool)haxeEnum.arguments[2];
                ret.multi = (bool)haxeEnum.arguments[3];
                ret.next = BreakpointList.FromEnum((HaxeEnum)haxeEnum.arguments[4]);
                return ret;
            }
            throw new InvalidCastException("Unknown constructor "+haxeEnum.constructor+" for HaxeEnum "+haxeEnum.name);
        }

        public class Terminator : BreakpointList
        {
            public override string ToString()
            {
                return "[BreakpointList.Terminator()]";
            }
        }

        public class Breakpoint : BreakpointList
        {
            public int number { get; set; }
            public string description { get; set; }
            public bool enabled { get; set; }
            public bool multi { get; set; }
            public BreakpointList next { get; set; }
            public override string ToString()
            {
                return "[BreakpointList.Breakpoint(number=" + number + ", description=" + description + ", enabled=" + enabled + ", multi=" + multi + ", next=" + next + ")]";
            }
        }

    }

    class BreakpointLocationList
    {
        public static BreakpointLocationList FromEnum(HaxeEnum haxeEnum)
        {
            if (haxeEnum.name != "debugger.BreakpointLocationList") { throw new InvalidCastException("Trying to case HaxeEnum "+haxeEnum.name+" to debugger.Message"); }
            if (haxeEnum.constructor == "Terminator") {
                Terminator ret = new Terminator();
                return ret;
            }
            if (haxeEnum.constructor == "FileLine") {
                FileLine ret = new FileLine();
                ret.fileName = (string)haxeEnum.arguments[0];
                ret.lineNumber = (int)haxeEnum.arguments[1];
                ret.next = BreakpointLocationList.FromEnum((HaxeEnum)haxeEnum.arguments[2]);
                return ret;
            }
            if (haxeEnum.constructor == "ClassFunction") {
                ClassFunction ret = new ClassFunction();
                ret.className = (string)haxeEnum.arguments[0];
                ret.functionName = (string)haxeEnum.arguments[1];
                ret.next = BreakpointLocationList.FromEnum((HaxeEnum)haxeEnum.arguments[2]);
                return ret;
            }
            throw new InvalidCastException("Unknown constructor "+haxeEnum.constructor+" for HaxeEnum "+haxeEnum.name);
        }

        public class Terminator : BreakpointLocationList
        {
            public override string ToString()
            {
                return "[BreakpointLocationList.Terminator()]";
            }
        }

        public class FileLine : BreakpointLocationList
        {
            public string fileName { get; set; }
            public int lineNumber { get; set; }
            public BreakpointLocationList next { get; set; }
            public override string ToString()
            {
                return "[BreakpointLocationList.FileLine(fileName=" + fileName + ", lineNumber=" + lineNumber + ", next=" + next + ")]";
            }
        }

        public class ClassFunction : BreakpointLocationList
        {
            public string className { get; set; }
            public string functionName { get; set; }
            public BreakpointLocationList next { get; set; }
            public override string ToString()
            {
                return "[BreakpointLocationList.ClassFunction(className=" + className + ", functionName=" + functionName + ", next=" + next + ")]";
            }
        }

    }

    class BreakpointStatusList
    {
        public static BreakpointStatusList FromEnum(HaxeEnum haxeEnum)
        {
            if (haxeEnum.name != "debugger.BreakpointStatusList") { throw new InvalidCastException("Trying to case HaxeEnum "+haxeEnum.name+" to debugger.Message"); }
            if (haxeEnum.constructor == "Terminator") {
                Terminator ret = new Terminator();
                return ret;
            }
            if (haxeEnum.constructor == "Nonexistent") {
                Nonexistent ret = new Nonexistent();
                ret.number = (int)haxeEnum.arguments[0];
                ret.next = BreakpointStatusList.FromEnum((HaxeEnum)haxeEnum.arguments[1]);
                return ret;
            }
            if (haxeEnum.constructor == "Disabled") {
                Disabled ret = new Disabled();
                ret.number = (int)haxeEnum.arguments[0];
                ret.next = BreakpointStatusList.FromEnum((HaxeEnum)haxeEnum.arguments[1]);
                return ret;
            }
            if (haxeEnum.constructor == "AlreadyDisabled") {
                AlreadyDisabled ret = new AlreadyDisabled();
                ret.number = (int)haxeEnum.arguments[0];
                ret.next = BreakpointStatusList.FromEnum((HaxeEnum)haxeEnum.arguments[1]);
                return ret;
            }
            if (haxeEnum.constructor == "Enabled") {
                Enabled ret = new Enabled();
                ret.number = (int)haxeEnum.arguments[0];
                ret.next = BreakpointStatusList.FromEnum((HaxeEnum)haxeEnum.arguments[1]);
                return ret;
            }
            if (haxeEnum.constructor == "AlreadyEnabled") {
                AlreadyEnabled ret = new AlreadyEnabled();
                ret.number = (int)haxeEnum.arguments[0];
                ret.next = BreakpointStatusList.FromEnum((HaxeEnum)haxeEnum.arguments[1]);
                return ret;
            }
            if (haxeEnum.constructor == "Deleted") {
                Deleted ret = new Deleted();
                ret.number = (int)haxeEnum.arguments[0];
                ret.next = BreakpointStatusList.FromEnum((HaxeEnum)haxeEnum.arguments[1]);
                return ret;
            }
            throw new InvalidCastException("Unknown constructor "+haxeEnum.constructor+" for HaxeEnum "+haxeEnum.name);
        }

        public class Terminator : BreakpointStatusList
        {
            public override string ToString()
            {
                return "[BreakpointStatusList.Terminator()]";
            }
        }

        public class Nonexistent : BreakpointStatusList
        {
            public int number { get; set; }
            public BreakpointStatusList next { get; set; }
            public override string ToString()
            {
                return "[BreakpointStatusList.Nonexistent(number=" + number + ", next=" + next + ")]";
            }
        }

        public class Disabled : BreakpointStatusList
        {
            public int number { get; set; }
            public BreakpointStatusList next { get; set; }
            public override string ToString()
            {
                return "[BreakpointStatusList.Disabled(number=" + number + ", next=" + next + ")]";
            }
        }

        public class AlreadyDisabled : BreakpointStatusList
        {
            public int number { get; set; }
            public BreakpointStatusList next { get; set; }
            public override string ToString()
            {
                return "[BreakpointStatusList.AlreadyDisabled(number=" + number + ", next=" + next + ")]";
            }
        }

        public class Enabled : BreakpointStatusList
        {
            public int number { get; set; }
            public BreakpointStatusList next { get; set; }
            public override string ToString()
            {
                return "[BreakpointStatusList.Enabled(number=" + number + ", next=" + next + ")]";
            }
        }

        public class AlreadyEnabled : BreakpointStatusList
        {
            public int number { get; set; }
            public BreakpointStatusList next { get; set; }
            public override string ToString()
            {
                return "[BreakpointStatusList.AlreadyEnabled(number=" + number + ", next=" + next + ")]";
            }
        }

        public class Deleted : BreakpointStatusList
        {
            public int number { get; set; }
            public BreakpointStatusList next { get; set; }
            public override string ToString()
            {
                return "[BreakpointStatusList.Deleted(number=" + number + ", next=" + next + ")]";
            }
        }

    }

    class ThreadStatus
    {
        public static ThreadStatus FromEnum(HaxeEnum haxeEnum)
        {
            if (haxeEnum.name != "debugger.ThreadStatus") { throw new InvalidCastException("Trying to case HaxeEnum "+haxeEnum.name+" to debugger.Message"); }
            if (haxeEnum.constructor == "Running") {
                Running ret = new Running();
                return ret;
            }
            if (haxeEnum.constructor == "StoppedImmediate") {
                StoppedImmediate ret = new StoppedImmediate();
                return ret;
            }
            if (haxeEnum.constructor == "StoppedBreakpoint") {
                StoppedBreakpoint ret = new StoppedBreakpoint();
                ret.number = (int)haxeEnum.arguments[0];
                return ret;
            }
            if (haxeEnum.constructor == "StoppedUncaughtException") {
                StoppedUncaughtException ret = new StoppedUncaughtException();
                return ret;
            }
            if (haxeEnum.constructor == "StoppedCriticalError") {
                StoppedCriticalError ret = new StoppedCriticalError();
                ret.description = (string)haxeEnum.arguments[0];
                return ret;
            }
            throw new InvalidCastException("Unknown constructor "+haxeEnum.constructor+" for HaxeEnum "+haxeEnum.name);
        }

        public class Running : ThreadStatus
        {
            public override string ToString()
            {
                return "[ThreadStatus.Running()]";
            }
        }

        public class StoppedImmediate : ThreadStatus
        {
            public override string ToString()
            {
                return "[ThreadStatus.StoppedImmediate()]";
            }
        }

        public class StoppedBreakpoint : ThreadStatus
        {
            public int number { get; set; }
            public override string ToString()
            {
                return "[ThreadStatus.StoppedBreakpoint(number=" + number + ")]";
            }
        }

        public class StoppedUncaughtException : ThreadStatus
        {
            public override string ToString()
            {
                return "[ThreadStatus.StoppedUncaughtException()]";
            }
        }

        public class StoppedCriticalError : ThreadStatus
        {
            public string description { get; set; }
            public override string ToString()
            {
                return "[ThreadStatus.StoppedCriticalError(description=" + description + ")]";
            }
        }

    }

    class FrameList
    {
        public static FrameList FromEnum(HaxeEnum haxeEnum)
        {
            if (haxeEnum.name != "debugger.FrameList") { throw new InvalidCastException("Trying to case HaxeEnum "+haxeEnum.name+" to debugger.Message"); }
            if (haxeEnum.constructor == "Terminator") {
                Terminator ret = new Terminator();
                return ret;
            }
            if (haxeEnum.constructor == "Frame") {
                Frame ret = new Frame();
                ret.isCurrent = (bool)haxeEnum.arguments[0];
                ret.number = (int)haxeEnum.arguments[1];
                ret.className = (string)haxeEnum.arguments[2];
                ret.functionName = (string)haxeEnum.arguments[3];
                ret.fileName = (string)haxeEnum.arguments[4];
                ret.lineNumber = (int)haxeEnum.arguments[5];
                ret.next = FrameList.FromEnum((HaxeEnum)haxeEnum.arguments[6]);
                return ret;
            }
            throw new InvalidCastException("Unknown constructor "+haxeEnum.constructor+" for HaxeEnum "+haxeEnum.name);
        }

        public class Terminator : FrameList
        {
            public override string ToString()
            {
                return "[FrameList.Terminator()]";
            }
        }

        public class Frame : FrameList
        {
            public bool isCurrent { get; set; }
            public int number { get; set; }
            public string className { get; set; }
            public string functionName { get; set; }
            public string fileName { get; set; }
            public int lineNumber { get; set; }
            public FrameList next { get; set; }
            public override string ToString()
            {
                return "[FrameList.Frame(isCurrent=" + isCurrent + ", number=" + number + ", className=" + className + ", functionName=" + functionName + ", fileName=" + fileName + ", lineNumber=" + lineNumber + ", next=" + next + ")]";
            }
        }

    }

    class ThreadWhereList
    {
        public static ThreadWhereList FromEnum(HaxeEnum haxeEnum)
        {
            if (haxeEnum.name != "debugger.ThreadWhereList") { throw new InvalidCastException("Trying to case HaxeEnum "+haxeEnum.name+" to debugger.Message"); }
            if (haxeEnum.constructor == "Terminator") {
                Terminator ret = new Terminator();
                return ret;
            }
            if (haxeEnum.constructor == "Where") {
                Where ret = new Where();
                ret.number = (int)haxeEnum.arguments[0];
                ret.status = ThreadStatus.FromEnum((HaxeEnum)haxeEnum.arguments[1]);
                ret.frameList = FrameList.FromEnum((HaxeEnum)haxeEnum.arguments[2]);
                ret.next = ThreadWhereList.FromEnum((HaxeEnum)haxeEnum.arguments[3]);
                return ret;
            }
            throw new InvalidCastException("Unknown constructor "+haxeEnum.constructor+" for HaxeEnum "+haxeEnum.name);
        }

        public class Terminator : ThreadWhereList
        {
            public override string ToString()
            {
                return "[ThreadWhereList.Terminator()]";
            }
        }

        public class Where : ThreadWhereList
        {
            public int number { get; set; }
            public ThreadStatus status { get; set; }
            public FrameList frameList { get; set; }
            public ThreadWhereList next { get; set; }
            public override string ToString()
            {
                return "[ThreadWhereList.Where(number=" + number + ", status=" + status + ", frameList=" + frameList + ", next=" + next + ")]";
            }
        }

    }

    class VariableValue
    {
        public static VariableValue FromEnum(HaxeEnum haxeEnum)
        {
            if (haxeEnum.name != "debugger.VariableValue") { throw new InvalidCastException("Trying to case HaxeEnum "+haxeEnum.name+" to debugger.Message"); }
            if (haxeEnum.constructor == "Item") {
                Item ret = new Item();
                ret.type = (string)haxeEnum.arguments[0];
                ret.value = (string)haxeEnum.arguments[1];
                ret.children = VariableNameList.FromEnum((HaxeEnum)haxeEnum.arguments[2]);
                return ret;
            }
            throw new InvalidCastException("Unknown constructor "+haxeEnum.constructor+" for HaxeEnum "+haxeEnum.name);
        }

        public class Item : VariableValue
        {
            public string type { get; set; }
            public string value { get; set; }
            public VariableNameList children { get; set; }
            public override string ToString()
            {
                return "[VariableValue.Item(type=" + type + ", value=" + value + ", children=" + children + ")]";
            }
        }

    }

    class VariableName
    {
        public static VariableName FromEnum(HaxeEnum haxeEnum)
        {
            if (haxeEnum.name != "debugger.VariableName") { throw new InvalidCastException("Trying to case HaxeEnum "+haxeEnum.name+" to debugger.Message"); }
            if (haxeEnum.constructor == "Variable") {
                Variable ret = new Variable();
                ret.name = (string)haxeEnum.arguments[0];
                ret.fullName = (string)haxeEnum.arguments[1];
                ret.value = VariableValue.FromEnum((HaxeEnum)haxeEnum.arguments[2]);
                return ret;
            }
            if (haxeEnum.constructor == "VariableNoValue") {
                VariableNoValue ret = new VariableNoValue();
                ret.name = (string)haxeEnum.arguments[0];
                ret.fullName = (string)haxeEnum.arguments[1];
                return ret;
            }
            throw new InvalidCastException("Unknown constructor "+haxeEnum.constructor+" for HaxeEnum "+haxeEnum.name);
        }

        public class Variable : VariableName
        {
            public string name { get; set; }
            public string fullName { get; set; }
            public VariableValue value { get; set; }
            public override string ToString()
            {
                return "[VariableName.Variable(name=" + name + ", fullName=" + fullName + ", value=" + value + ")]";
            }
        }

        public class VariableNoValue : VariableName
        {
            public string name { get; set; }
            public string fullName { get; set; }
            public override string ToString()
            {
                return "[VariableName.VariableNoValue(name=" + name + ", fullName=" + fullName + ")]";
            }
        }

    }

    class VariableNameList
    {
        public static VariableNameList FromEnum(HaxeEnum haxeEnum)
        {
            if (haxeEnum.name != "debugger.VariableNameList") { throw new InvalidCastException("Trying to case HaxeEnum "+haxeEnum.name+" to debugger.Message"); }
            if (haxeEnum.constructor == "Terminator") {
                Terminator ret = new Terminator();
                return ret;
            }
            if (haxeEnum.constructor == "Element") {
                Element ret = new Element();
                ret.variable = VariableName.FromEnum((HaxeEnum)haxeEnum.arguments[0]);
                ret.next = VariableNameList.FromEnum((HaxeEnum)haxeEnum.arguments[1]);
                return ret;
            }
            throw new InvalidCastException("Unknown constructor "+haxeEnum.constructor+" for HaxeEnum "+haxeEnum.name);
        }

        public class Terminator : VariableNameList
        {
            public override string ToString()
            {
                return "[VariableNameList.Terminator()]";
            }
        }

        public class Element : VariableNameList
        {
            public VariableName variable { get; set; }
            public VariableNameList next { get; set; }
            public override string ToString()
            {
                return "[VariableNameList.Element(variable=" + variable + ", next=" + next + ")]";
            }
        }

    }

    class Message
    {
        public static Message FromEnum(HaxeEnum haxeEnum)
        {
            if (haxeEnum.name != "debugger.Message") { throw new InvalidCastException("Trying to case HaxeEnum "+haxeEnum.name+" to debugger.Message"); }
            if (haxeEnum.constructor == "ErrorInternal") {
                ErrorInternal ret = new ErrorInternal();
                ret.details = (string)haxeEnum.arguments[0];
                return ret;
            }
            if (haxeEnum.constructor == "ErrorNoSuchThread") {
                ErrorNoSuchThread ret = new ErrorNoSuchThread();
                ret.number = (int)haxeEnum.arguments[0];
                return ret;
            }
            if (haxeEnum.constructor == "ErrorNoSuchFile") {
                ErrorNoSuchFile ret = new ErrorNoSuchFile();
                ret.fileName = (string)haxeEnum.arguments[0];
                return ret;
            }
            if (haxeEnum.constructor == "ErrorNoSuchBreakpoint") {
                ErrorNoSuchBreakpoint ret = new ErrorNoSuchBreakpoint();
                ret.number = (int)haxeEnum.arguments[0];
                return ret;
            }
            if (haxeEnum.constructor == "ErrorBadClassNameRegex") {
                ErrorBadClassNameRegex ret = new ErrorBadClassNameRegex();
                ret.details = (string)haxeEnum.arguments[0];
                return ret;
            }
            if (haxeEnum.constructor == "ErrorBadFunctionNameRegex") {
                ErrorBadFunctionNameRegex ret = new ErrorBadFunctionNameRegex();
                ret.details = (string)haxeEnum.arguments[0];
                return ret;
            }
            if (haxeEnum.constructor == "ErrorNoMatchingFunctions") {
                ErrorNoMatchingFunctions ret = new ErrorNoMatchingFunctions();
                ret.className = (string)haxeEnum.arguments[0];
                ret.functionName = (string)haxeEnum.arguments[1];
                ret.unresolvableClasses = StringList.FromEnum((HaxeEnum)haxeEnum.arguments[2]);
                return ret;
            }
            if (haxeEnum.constructor == "ErrorBadCount") {
                ErrorBadCount ret = new ErrorBadCount();
                ret.count = (int)haxeEnum.arguments[0];
                return ret;
            }
            if (haxeEnum.constructor == "ErrorCurrentThreadNotStopped") {
                ErrorCurrentThreadNotStopped ret = new ErrorCurrentThreadNotStopped();
                ret.threadNumber = (int)haxeEnum.arguments[0];
                return ret;
            }
            if (haxeEnum.constructor == "ErrorEvaluatingExpression") {
                ErrorEvaluatingExpression ret = new ErrorEvaluatingExpression();
                ret.details = (string)haxeEnum.arguments[0];
                return ret;
            }
            if (haxeEnum.constructor == "OK") {
                OK ret = new OK();
                return ret;
            }
            if (haxeEnum.constructor == "Exited") {
                Exited ret = new Exited();
                return ret;
            }
            if (haxeEnum.constructor == "Detached") {
                Detached ret = new Detached();
                return ret;
            }
            if (haxeEnum.constructor == "Files") {
                Files ret = new Files();
                ret.list = StringList.FromEnum((HaxeEnum)haxeEnum.arguments[0]);
                return ret;
            }
            if (haxeEnum.constructor == "Classes") {
                Classes ret = new Classes();
                ret.list = StringList.FromEnum((HaxeEnum)haxeEnum.arguments[0]);
                return ret;
            }
            if (haxeEnum.constructor == "MemBytes") {
                MemBytes ret = new MemBytes();
                ret.bytes = (int)haxeEnum.arguments[0];
                return ret;
            }
            if (haxeEnum.constructor == "Compacted") {
                Compacted ret = new Compacted();
                ret.bytesBefore = (int)haxeEnum.arguments[0];
                ret.bytesAfter = (int)haxeEnum.arguments[1];
                return ret;
            }
            if (haxeEnum.constructor == "Collected") {
                Collected ret = new Collected();
                ret.bytesBefore = (int)haxeEnum.arguments[0];
                ret.bytesAfter = (int)haxeEnum.arguments[1];
                return ret;
            }
            if (haxeEnum.constructor == "CurrentThread") {
                CurrentThread ret = new CurrentThread();
                ret.number = (int)haxeEnum.arguments[0];
                return ret;
            }
            if (haxeEnum.constructor == "FileLineBreakpointNumber") {
                FileLineBreakpointNumber ret = new FileLineBreakpointNumber();
                ret.number = (int)haxeEnum.arguments[0];
                return ret;
            }
            if (haxeEnum.constructor == "ClassFunctionBreakpointNumber") {
                ClassFunctionBreakpointNumber ret = new ClassFunctionBreakpointNumber();
                ret.number = (int)haxeEnum.arguments[0];
                ret.unresolvableClasses = StringList.FromEnum((HaxeEnum)haxeEnum.arguments[1]);
                return ret;
            }
            if (haxeEnum.constructor == "Breakpoints") {
                Breakpoints ret = new Breakpoints();
                ret.list = BreakpointList.FromEnum((HaxeEnum)haxeEnum.arguments[0]);
                return ret;
            }
            if (haxeEnum.constructor == "BreakpointDescription") {
                BreakpointDescription ret = new BreakpointDescription();
                ret.number = (int)haxeEnum.arguments[0];
                ret.list = BreakpointLocationList.FromEnum((HaxeEnum)haxeEnum.arguments[1]);
                return ret;
            }
            if (haxeEnum.constructor == "BreakpointStatuses") {
                BreakpointStatuses ret = new BreakpointStatuses();
                ret.list = BreakpointStatusList.FromEnum((HaxeEnum)haxeEnum.arguments[0]);
                return ret;
            }
            if (haxeEnum.constructor == "Continued") {
                Continued ret = new Continued();
                ret.count = (int)haxeEnum.arguments[0];
                return ret;
            }
            if (haxeEnum.constructor == "ThreadsWhere") {
                ThreadsWhere ret = new ThreadsWhere();
                ret.list = ThreadWhereList.FromEnum((HaxeEnum)haxeEnum.arguments[0]);
                return ret;
            }
            if (haxeEnum.constructor == "CurrentFrame") {
                CurrentFrame ret = new CurrentFrame();
                ret.number = (int)haxeEnum.arguments[0];
                return ret;
            }
            if (haxeEnum.constructor == "Variables") {
                Variables ret = new Variables();
                ret.list = StringList.FromEnum((HaxeEnum)haxeEnum.arguments[0]);
                return ret;
            }
            if (haxeEnum.constructor == "Value") {
                Value ret = new Value();
                ret.expression = (string)haxeEnum.arguments[0];
                ret.type = (string)haxeEnum.arguments[1];
                ret.value = (string)haxeEnum.arguments[2];
                return ret;
            }
            if (haxeEnum.constructor == "ThreadCreated") {
                ThreadCreated ret = new ThreadCreated();
                ret.number = (int)haxeEnum.arguments[0];
                return ret;
            }
            if (haxeEnum.constructor == "ThreadTerminated") {
                ThreadTerminated ret = new ThreadTerminated();
                ret.number = (int)haxeEnum.arguments[0];
                return ret;
            }
            if (haxeEnum.constructor == "ThreadStarted") {
                ThreadStarted ret = new ThreadStarted();
                ret.number = (int)haxeEnum.arguments[0];
                return ret;
            }
            if (haxeEnum.constructor == "ThreadStopped") {
                ThreadStopped ret = new ThreadStopped();
                ret.number = (int)haxeEnum.arguments[0];
                ret.className = (string)haxeEnum.arguments[1];
                ret.functionName = (string)haxeEnum.arguments[2];
                ret.fileName = (string)haxeEnum.arguments[3];
                ret.lineNumber = (int)haxeEnum.arguments[4];
                return ret;
            }
            if (haxeEnum.constructor == "MessageId") {
                MessageId ret = new MessageId();
                ret.id = (int)haxeEnum.arguments[0];
                ret.message = Message.FromEnum((HaxeEnum)haxeEnum.arguments[1]);
                return ret;
            }
            if (haxeEnum.constructor == "Variable") {
                Variable ret = new Variable();
                ret.variable = VariableName.FromEnum((HaxeEnum)haxeEnum.arguments[0]);
                return ret;
            }
            throw new InvalidCastException("Unknown constructor "+haxeEnum.constructor+" for HaxeEnum "+haxeEnum.name);
        }

        public class ErrorInternal : Message
        {
            public string details { get; set; }
            public override string ToString()
            {
                return "[Message.ErrorInternal(details=" + details + ")]";
            }
        }

        public class ErrorNoSuchThread : Message
        {
            public int number { get; set; }
            public override string ToString()
            {
                return "[Message.ErrorNoSuchThread(number=" + number + ")]";
            }
        }

        public class ErrorNoSuchFile : Message
        {
            public string fileName { get; set; }
            public override string ToString()
            {
                return "[Message.ErrorNoSuchFile(fileName=" + fileName + ")]";
            }
        }

        public class ErrorNoSuchBreakpoint : Message
        {
            public int number { get; set; }
            public override string ToString()
            {
                return "[Message.ErrorNoSuchBreakpoint(number=" + number + ")]";
            }
        }

        public class ErrorBadClassNameRegex : Message
        {
            public string details { get; set; }
            public override string ToString()
            {
                return "[Message.ErrorBadClassNameRegex(details=" + details + ")]";
            }
        }

        public class ErrorBadFunctionNameRegex : Message
        {
            public string details { get; set; }
            public override string ToString()
            {
                return "[Message.ErrorBadFunctionNameRegex(details=" + details + ")]";
            }
        }

        public class ErrorNoMatchingFunctions : Message
        {
            public string className { get; set; }
            public string functionName { get; set; }
            public StringList unresolvableClasses { get; set; }
            public override string ToString()
            {
                return "[Message.ErrorNoMatchingFunctions(className=" + className + ", functionName=" + functionName + ", unresolvableClasses=" + unresolvableClasses + ")]";
            }
        }

        public class ErrorBadCount : Message
        {
            public int count { get; set; }
            public override string ToString()
            {
                return "[Message.ErrorBadCount(count=" + count + ")]";
            }
        }

        public class ErrorCurrentThreadNotStopped : Message
        {
            public int threadNumber { get; set; }
            public override string ToString()
            {
                return "[Message.ErrorCurrentThreadNotStopped(threadNumber=" + threadNumber + ")]";
            }
        }

        public class ErrorEvaluatingExpression : Message
        {
            public string details { get; set; }
            public override string ToString()
            {
                return "[Message.ErrorEvaluatingExpression(details=" + details + ")]";
            }
        }

        public class OK : Message
        {
            public override string ToString()
            {
                return "[Message.OK()]";
            }
        }

        public class Exited : Message
        {
            public override string ToString()
            {
                return "[Message.Exited()]";
            }
        }

        public class Detached : Message
        {
            public override string ToString()
            {
                return "[Message.Detached()]";
            }
        }

        public class Files : Message
        {
            public StringList list { get; set; }
            public override string ToString()
            {
                return "[Message.Files(list=" + list + ")]";
            }
        }

        public class Classes : Message
        {
            public StringList list { get; set; }
            public override string ToString()
            {
                return "[Message.Classes(list=" + list + ")]";
            }
        }

        public class MemBytes : Message
        {
            public int bytes { get; set; }
            public override string ToString()
            {
                return "[Message.MemBytes(bytes=" + bytes + ")]";
            }
        }

        public class Compacted : Message
        {
            public int bytesBefore { get; set; }
            public int bytesAfter { get; set; }
            public override string ToString()
            {
                return "[Message.Compacted(bytesBefore=" + bytesBefore + ", bytesAfter=" + bytesAfter + ")]";
            }
        }

        public class Collected : Message
        {
            public int bytesBefore { get; set; }
            public int bytesAfter { get; set; }
            public override string ToString()
            {
                return "[Message.Collected(bytesBefore=" + bytesBefore + ", bytesAfter=" + bytesAfter + ")]";
            }
        }

        public class CurrentThread : Message
        {
            public int number { get; set; }
            public override string ToString()
            {
                return "[Message.CurrentThread(number=" + number + ")]";
            }
        }

        public class FileLineBreakpointNumber : Message
        {
            public int number { get; set; }
            public override string ToString()
            {
                return "[Message.FileLineBreakpointNumber(number=" + number + ")]";
            }
        }

        public class ClassFunctionBreakpointNumber : Message
        {
            public int number { get; set; }
            public StringList unresolvableClasses { get; set; }
            public override string ToString()
            {
                return "[Message.ClassFunctionBreakpointNumber(number=" + number + ", unresolvableClasses=" + unresolvableClasses + ")]";
            }
        }

        public class Breakpoints : Message
        {
            public BreakpointList list { get; set; }
            public override string ToString()
            {
                return "[Message.Breakpoints(list=" + list + ")]";
            }
        }

        public class BreakpointDescription : Message
        {
            public int number { get; set; }
            public BreakpointLocationList list { get; set; }
            public override string ToString()
            {
                return "[Message.BreakpointDescription(number=" + number + ", list=" + list + ")]";
            }
        }

        public class BreakpointStatuses : Message
        {
            public BreakpointStatusList list { get; set; }
            public override string ToString()
            {
                return "[Message.BreakpointStatuses(list=" + list + ")]";
            }
        }

        public class Continued : Message
        {
            public int count { get; set; }
            public override string ToString()
            {
                return "[Message.Continued(count=" + count + ")]";
            }
        }

        public class ThreadsWhere : Message
        {
            public ThreadWhereList list { get; set; }
            public override string ToString()
            {
                return "[Message.ThreadsWhere(list=" + list + ")]";
            }
        }

        public class CurrentFrame : Message
        {
            public int number { get; set; }
            public override string ToString()
            {
                return "[Message.CurrentFrame(number=" + number + ")]";
            }
        }

        public class Variables : Message
        {
            public StringList list { get; set; }
            public override string ToString()
            {
                return "[Message.Variables(list=" + list + ")]";
            }
        }

        public class Value : Message
        {
            public string expression { get; set; }
            public string type { get; set; }
            public string value { get; set; }
            public override string ToString()
            {
                return "[Message.Value(expression=" + expression + ", type=" + type + ", value=" + value + ")]";
            }
        }

        public class ThreadCreated : Message
        {
            public int number { get; set; }
            public override string ToString()
            {
                return "[Message.ThreadCreated(number=" + number + ")]";
            }
        }

        public class ThreadTerminated : Message
        {
            public int number { get; set; }
            public override string ToString()
            {
                return "[Message.ThreadTerminated(number=" + number + ")]";
            }
        }

        public class ThreadStarted : Message
        {
            public int number { get; set; }
            public override string ToString()
            {
                return "[Message.ThreadStarted(number=" + number + ")]";
            }
        }

        public class ThreadStopped : Message
        {
            public int number { get; set; }
            public string className { get; set; }
            public string functionName { get; set; }
            public string fileName { get; set; }
            public int lineNumber { get; set; }
            public override string ToString()
            {
                return "[Message.ThreadStopped(number=" + number + ", className=" + className + ", functionName=" + functionName + ", fileName=" + fileName + ", lineNumber=" + lineNumber + ")]";
            }
        }

        public class MessageId : Message
        {
            public int id { get; set; }
            public Message message { get; set; }
            public override string ToString()
            {
                return "[Message.MessageId(id=" + id + ", message=" + message + ")]";
            }
        }

        public class Variable : Message
        {
            public VariableName variable { get; set; }
            public override string ToString()
            {
                return "[Message.Variable(variable=" + variable + ")]";
            }
        }

    }
}
