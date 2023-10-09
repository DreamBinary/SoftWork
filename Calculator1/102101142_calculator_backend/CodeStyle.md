## CodeStyle

from https://google.github.io/styleguide/pyguide.html

1. 所有新代码都应按完整包名称导入每个模块。

```python
# Reference absl.flags in code with the complete name (verbose).
import absl.flags
from doctor.who import jodie

FLAGS = absl.flags.FLAGS
```

2. 默认参数值

```python
正确： def foo(a, b=None):
         if b is None:
             b = []
正确： def foo(a, b: Optional[Sequence] = None):
         if b is None:
             b = []
正确： def foo(a, b: Sequence = ()):  # Empty tuple OK since tuples are immutable
```

```python
错误：  def foo(a, b=[]):
         ...
错误：  def foo(a, b=time.time()):  # The time the module was loaded???
         ...
错误：  def foo(a, b=FLAGS.my_thing):  # sys.argv has not yet been parsed...
         ...
错误：  def foo(a, b: Mapping = {}):  # Could still get passed to unchecked code
         ...
```

3. 异常

```python
正确：
  def connect_to_next_port(self, minimum):
    """Connects to the next available port.

    Args:
      minimum: A port value greater or equal to 1024.

    Returns:
      The new minimum port.

    Raises:
      ConnectionError: If no available port is found.
    """
    if minimum < 1024:
      # Note that this raising of ValueError is not mentioned in the doc
      # string's "Raises:" section because it is not appropriate to
      # guarantee this specific behavioral reaction to API misuse.
      raise ValueError('Minimum port must be at least 1024, not %d.' % (minimum,))
    port = self._find_next_open_port(minimum)
    if not port:
      raise ConnectionError('Could not connect to service on %d or higher.' % (minimum,))
    assert port >= minimum, 'Unexpected port %d when minimum was %d.' % (port, minimum)
    return port
```

```python
错误：
  def connect_to_next_port(self, minimum):
    """Connects to the next available port.

    Args:
      minimum: A port value greater or equal to 1024.

    Returns:
      The new minimum port.
    """
    assert minimum >= 1024, 'Minimum port must be at least 1024.'
    port = self._find_next_open_port(minimum)
    assert port is not None
    return port
```

4. 缩进

用 *4 个空格* 缩进代码块。

切勿使用 Tab 或混合 Tab 和空格。 在隐含线延续的情况下，您应该垂直对齐包装的元素，如[行长度](https://google.github.io/styleguide/pyguide.html#s3.2-line-length)部分中的示例所示;或使用 4 个空格的悬挂缩进，在这种情况下，在第一行的打开括号或括号后不应有任何内容。

5. 空格

遵循标准排版规则来使用标点符号前后的空格。

圆括号、方括号和花括号的内侧没有空格。

6. 注释

最后需要添加注释的位置是代码的难懂部分。 如果你要在下一次[代码评审](http://en.wikipedia.org/wiki/Code_review)时解释它，你应该现在就添加注释。 复杂的操作在开始之前加几行注释。 非显而易见的操作在行尾加上注释。

```python
# We use a weighted dictionary search to find out where i is in
# the array.  We extrapolate position based on the largest num
# in the array and the array size and then do binary search to
# get the exact number.

if i & (i-1) == 0:  # True if i is 0 or a power of 2.
```

为了提高可读性，这些注释应从注释字符`#`的代码开始至少 2 个空格，然后至少一个空格位于注释本身的文本之前。

另一方面，切勿描述代码。 假设阅读代码的人比你更了解 Python（虽然不是你正在做什么）。

```Pytho
# BAD COMMENT: Now go through the b array and make sure whenever i occurs
# the next element is i+1
```

