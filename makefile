EXECUTABLE := main # 可执行文件名
LIBDIR:=/home/liu/下载/gtest-1.6.0 # 静态库目录
LIBS :=gtest pthread # 静态库文件名
INCLUDES:=/home/liu/下载/gtest-1.6.0/include # 头文件目录
SRCDIR:=	# 除了当前目录外，其他的源代码文件目录
CC:=g++ 
CFLAGS := -fprofile-arcs -ftest-coverage -g -Wall -O3
CPPFLAGS := $(CFLAGS)
CPPFLAGS += $(addprefix -I,$(INCLUDES))
CPPFLAGS += -MMD

RM-F := rm -f
SRCS := $(wildcard *.cpp) $(wildcard $(addsuffix /*.cpp, $(SRCDIR)))
OBJS := $(patsubst %.cpp,%.o,$(SRCS))
DEPS := $(patsubst %.o,%.d,$(OBJS))
MISSING_DEPS := $(filter-out $(wildcard $(DEPS)),$(DEPS))
MISSING_DEPS_SOURCES := $(wildcard $(patsubst %.d,%.cpp,$(MISSING_DEPS)))


.PHONY : all deps objs clean veryclean rebuild info

all: $(EXECUTABLE)
deps : $(DEPS)
objs : $(OBJS)
clean :
	@$(RM-F)	*.o
	@$(RM-F)	*.d
veryclean: clean
	@$(RM-F)	$(EXECUTABLE)
rebuild: veryclean all
ifneq ($(MISSING_DEPS),)
$(MISSING_DEPS) :
	@$(RM-F)	$(patsubst %.d,%.o,$@)
endif
-include $(DEPS)
$(EXECUTABLE) : $(OBJS)
	$(CC) -fprofile-arcs -ftest-coverage -o $(EXECUTABLE) $(OBJS) $(addprefix -L,$(LIBDIR)) $(addprefix -l,$(LIBS))

info:
	@echo $(SRCS)
	@echo $(OBJS)
	@echo $(DEPS)
	@echo $(MISSING_DEPS)
	@echo $(MISSING_DEPS_SOURCES)
