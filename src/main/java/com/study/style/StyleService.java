package com.study.style;

import java.util.List;
import java.util.Map;

public interface StyleService {
  int create(StyleDTO dto);

  List<StyleDTO> list(Map map);

  int delete(int imageno);
}
