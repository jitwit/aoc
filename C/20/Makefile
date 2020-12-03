.phony : phony $(days)

days = 1 2

run : $(day)
	./$(day) < ../../input/2020/$(day).in

% : %.c
	gcc -Wall -O2 -o $@ $<

tout : $(days)

clean :
	rm -f $(days)
