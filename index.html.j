<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>简·爱 人物关系图 | Jane Eyre Character Map</title>
<style>
  * { margin:0; padding:0; box-sizing:border-box; }
  body {
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
    background:#f5f2eb; color:#2c2c2c; line-height:1.7; padding:40px 20px;
  }
  .container { max-width:1060px; margin:0 auto; }
  header { text-align:center; margin-bottom:40px; }
  header h1 { font-size:2.2rem; font-weight:700; letter-spacing:1px; color:#1a1a1a; }
  header .sub { font-size:.95rem; color:#7a6e5d; margin-top:8px; letter-spacing:.5px; }
  header .desc { font-size:.9rem; color:#8a7e6d; margin-top:6px; }

  .map-section {
    background:#fffdf8; border-radius:16px; padding:28px 20px 20px;
    box-shadow:0 2px 12px rgba(0,0,0,.05); margin-bottom:40px;
  }
  .map-section h2 { font-size:1.3rem; margin-bottom:6px; color:#3d3529; text-align:center; }
  .map-hint { font-size:.85rem; color:#9a8e7d; margin-bottom:14px; text-align:center; }

  /* SVG 关系图 */
  #chartWrap { position:relative; width:100%; overflow:hidden; }
  svg#chart { width:100%; height:auto; display:block; user-select:none; }

  .edge {
    stroke:#d9d0c0; stroke-width:1.6; fill:none;
    transition: stroke .25s, stroke-width .25s, opacity .25s;
  }
  .edge.dim { opacity:.12; }
  .edge.hl { stroke-width:3; }
  .edge.hl.love    { stroke:#c47a5a; }
  .edge.hl.family  { stroke:#8a9a7a; }
  .edge.hl.conflict{ stroke:#b85c5c; }
  .edge.hl.friend  { stroke:#6a8aaa; }

  .edge-label { font-size:11px; fill:#9a8e7d; opacity:0; transition:opacity .25s; pointer-events:none; }
  .edge-label.hl { opacity:1; }

  .node-group { cursor:pointer; }
  .node-shape {
    stroke-width:1.8;
    transition: fill .25s, stroke .25s, transform .25s, opacity .25s;
    transform-box: fill-box; transform-origin:center;
  }
  .node-label {
    font-size:12.5px; font-weight:600; fill:#3d3529; text-anchor:middle;
    pointer-events:none; transition: opacity .25s;
  }
  .node-group.dim { opacity:.18; }
  .node-group.active .node-shape { transform: scale(1.08); }
  .node-group:hover .node-shape { transform: scale(1.05); }

  .node-shape.central { fill:#3d3529; stroke:#3d3529; }
  .node-shape.central + .node-label { fill:#f5f2eb; }
  .node-shape.love     { fill:#fdf5f0; stroke:#c47a5a; }
  .node-shape.family   { fill:#f4f7f0; stroke:#8a9a7a; }
  .node-shape.conflict { fill:#fdf0f0; stroke:#b85c5c; }
  .node-shape.friend   { fill:#f0f4fa; stroke:#6a8aaa; }

  .legend {
    display:flex; flex-wrap:wrap; justify-content:center; gap:18px;
    font-size:.82rem; color:#7a6e5d; margin-top:14px;
  }
  .legend span::before {
    content:""; display:inline-block; width:10px; height:10px; border-radius:50%;
    margin-right:5px; vertical-align:middle;
  }
  .legend .l-love::before{background:#c47a5a;}
  .legend .l-family::before{background:#8a9a7a;}
  .legend .l-conflict::before{background:#b85c5c;}
  .legend .l-friend::before{background:#6a8aaa;}

  .map-note { font-size:.8rem; color:#9a8e7d; margin-top:14px; font-style:italic; text-align:center; }

  /* 关系解读面板 */
  #panel {
    margin-top:18px; background:#fffdf8; border:1px dashed #d9d0c0;
    border-radius:12px; padding:16px 20px; font-size:.9rem; color:#5a5040;
    min-height:70px; transition:opacity .3s;
  }
  #panel .p-title { font-weight:600; color:#3d3529; margin-bottom:6px; }
  #panel .p-empty { color:#b0a898; font-style:italic; }
  #panel ul { list-style:none; margin-top:6px; }
  #panel li { padding:3px 0; }
  #panel li::before { content:"—"; color:#c47a5a; margin-right:8px; }

  /* 关键关系 */
  .key-section { margin-bottom:40px; }
  .key-section h2 { font-size:1.3rem; margin-bottom:20px; color:#3d3529; }
  .rel-card {
    background:#fffdf8; border-left:4px solid #c47a5a; border-radius:8px;
    padding:20px 24px; margin-bottom:16px; box-shadow:0 1px 6px rgba(0,0,0,.04);
  }
  .rel-card:nth-child(2){border-left-color:#8a9a7a;}
  .rel-card:nth-child(3){border-left-color:#b85c5c;}
  .rel-card:nth-child(4){border-left-color:#6a8aaa;}
  .rel-card:nth-child(5){border-left-color:#9a7aaa;}
  .rel-card:nth-child(6){border-left-color:#b89a5a;}
  .rel-card .rel-title { font-size:1.05rem; font-weight:600; color:#2c2c2c; margin-bottom:8px; }
  .rel-card .rel-title span { font-weight:400; font-size:.85rem; color:#9a8e7d; margin-left:8px; }
  .rel-card p { font-size:.9rem; color:#5a5040; }

  /* 速查表 */
  .table-section { margin-bottom:40px; }
  .table-section h2 { font-size:1.3rem; margin-bottom:16px; color:#3d3529; }
  table {
    width:100%; border-collapse:collapse; background:#fffdf8;
    border-radius:10px; overflow:hidden; box-shadow:0 1px 6px rgba(0,0,0,.04);
    font-size:.88rem;
  }
  th { background:#3d3529; color:#f5f2eb; text-align:left; padding:12px 16px; font-weight:500; }
  td { padding:12px 16px; border-bottom:1px solid #ede8df; color:#4a4030; }
  tr:last-child td { border-bottom:none; }
  tr:hover td { background:#faf7f2; }

  /* 台词 */
  .quote-section { margin-bottom:20px; }
  .quote-section h2 { font-size:1.3rem; margin-bottom:20px; color:#3d3529; }
  .quote-card {
    background:#fffdf8; border-radius:10px; padding:20px 24px;
    margin-bottom:16px; box-shadow:0 1px 6px rgba(0,0,0,.04);
  }
  .quote-card .speaker { font-size:.85rem; font-weight:600; color:#c47a5a; margin-bottom:6px; letter-spacing:.5px; }
  .quote-card blockquote {
    font-size:.95rem; color:#3d3529; font-style:italic; margin-bottom:8px;
    padding-left:14px; border-left:2px solid #d9d0c0;
  }
  .quote-card .trans { font-size:.88rem; color:#6a6050; margin-bottom:8px; }
  .quote-card .note { font-size:.82rem; color:#9a8e7d; }

  footer { text-align:center; font-size:.78rem; color:#b0a898; margin-top:40px; padding-top:20px; border-top:1px solid #e5dfd5; }

  @media (max-width:600px){
    body{padding:24px 14px;}
    header h1{font-size:1.6rem;}
    .node-label{font-size:10px;}
    table{font-size:.78rem;}
    th,td{padding:8px 10px;}
    #panel{font-size:.85rem;}
  }
</style>
</head>
<body>
<div class="container">

  <header>
    <h1>简·爱 人物关系图</h1>
    <div class="sub">Jane Eyre · Charlotte Brontë</div>
    <div class="desc">十一位主要人物的亲属、婚恋、友谊与冲突关系</div>
  </header>

  <section class="map-section">
    <h2>一张图看懂主要人物关系</h2>
    <p class="map-hint">点击图中人物，高亮其全部关系；再次点击空白处取消</p>

    <div id="chartWrap">
      <svg id="chart" viewBox="0 0 900 620" aria-label="简·爱人物关系图"></svg>
    </div>

    <div class="legend">
      <span class="l-love">爱慕 / 婚恋</span>
      <span class="l-family">亲属 / 友谊</span>
      <span class="l-conflict">冲突 / 压迫</span>
      <span class="l-friend">雇佣 / 照料</span>
    </div>

    <p class="map-note">注：图中只呈现主要人物之间的直接关系；英格拉姆小姐、奥利弗小姐等次要人物未列入，以免图面过密。</p>

    <div id="panel"><span class="p-empty">点击上方任意人物，这里会列出他/她与其他人物的全部关系。</span></div>
  </section>

  <section class="key-section">
    <h2>六组关键关系逐条拆解</h2>

    <div class="rel-card">
      <div class="rel-title">主线婚恋 · 简 & 罗切斯特 <span>Jane & Rochester</span></div>
      <p>桑菲尔德庄园的家庭教师与庄园主人，身份悬殊却灵魂对等。简在罗切斯特面前始终保持独立与尊严，那句“我们的精神是平等的”成为全书的核心宣言。婚礼上被揭穿罗切斯特已有疯妻伯莎，简拒绝以情妇身份留下，毅然出走。历经流浪、继承遗产与伯莎纵火身亡后，简回到双目失明、右手残废的罗切斯特身边，两人终于在平等中结合。书名所指向的，正是简在爱情中绝不放弃的自尊与原则。</p>
    </div>

    <div class="rel-card">
      <div class="rel-title">童年压迫 · 简 & 里德太太一家 <span>Jane & the Reeds</span></div>
      <p>简幼年寄居舅妈里德太太家，受尽歧视与虐待。表哥约翰无故殴打她，反被舅妈关进“红房子”禁闭，那次惊吓成为她童年最深的创伤。面对不公，简没有选择逆来顺受，而是当面反抗，喊出“我不是骗子”。里德太太临终前仍不愿真心和解，但简最终选择原谅。这段经历塑造了简对尊严的极度敏感，也解释了她日后在任何关系中都不肯屈就的性格根源。</p>
    </div>

    <div class="rel-card">
      <div class="rel-title">精神友谊 · 简 & 海伦·彭斯 <span>Jane & Helen Burns</span></div>
      <p>洛伍德学校里，海伦是简的第一个朋友。面对勃洛克赫斯特的羞辱与校内的苛待，海伦以近乎圣徒般的忍耐与宽恕回应，与简本能的反抗形成鲜明对照。海伦告诉简“生命太短，不该用来记恨”，这句话深深影响了简。海伦因肺病早逝，简在睡梦中与她无声告别。海伦的信仰与温柔，是简内心柔软一面的来源，也让她在日后学会在反抗之外保留宽恕的能力。</p>
    </div>

    <div class="rel-card">
      <div class="rel-title">表亲与求婚 · 圣约翰 & 简 <span>St. John & Jane</span></div>
      <p>简流浪至沼泽居，被圣约翰兄妹收留，后得知彼此是表亲，并继承了叔叔留下的遗产。圣约翰是虔诚而冷峻的传教士，他向简求婚并非出于爱情，而是认为简适合做传教士的妻子、能协助他在印度的使命。简几乎被他的意志说服，但在最后一刻听到了罗切斯特的呼唤，拒绝了这桩没有爱情的婚姻。圣约翰代表了以责任和宗教之名压抑情感的另一种人生可能，简的拒绝则再次确认了她对真实情感的坚持。</p>
    </div>

    <div class="rel-card">
      <div class="rel-title">被隐藏的障碍 · 罗切斯特 & 伯莎·梅森 <span>Rochester & Bertha</span></div>
      <p>伯莎是罗切斯特在牙买加被安排的妻子，患有精神疾病，被关在桑菲尔德庄园三楼密室，由格雷斯·普尔看管。她的存在是罗切斯特痛苦与秘密的源头，也是简的婚礼被中断的直接原因。小说结尾，伯莎纵火烧毁桑菲尔德，自己跳楼身亡，罗切斯特为救她而失明残废。伯莎既是罗切斯特过往错误的化身，也是简与罗切斯特之间必须被清除的障碍，她的死使两人的结合在道德与法律上都成为可能。</p>
    </div>

    <div class="rel-card">
      <div class="rel-title">制度压迫 · 简 & 勃洛克赫斯特 <span>Jane & Mr. Brocklehurst</span></div>
      <p>勃洛克赫斯特是洛伍德学校的司库与实际管理者，以宗教之名行苛刻之实。他当众宣布简是“说谎者”，让她在全校面前罚站，并以此羞辱里德太太推荐来的孩子。他自家享受优渥生活，却要求学生们忍受饥饿与寒冷，是全书中最鲜明的伪善者形象。简后来在谭波儿小姐的帮助下洗清污名，而勃洛克赫斯特的虚伪也让她更清楚地看到，以权威面目出现的“正义”未必值得服从。</p>
    </div>
  </section>

  <section class="table-section">
    <h2>人物身份速查表</h2>
    <table>
      <thead>
        <tr><th>人物</th><th>身份</th><th>关键关系</th></tr>
      </thead>
      <tbody>
        <tr><td>简·爱 Jane Eyre</td><td>孤儿，家庭教师</td><td>罗切斯特的爱人；海伦的朋友；圣约翰的表妹</td></tr>
        <tr><td>爱德华·罗切斯特 Edward Rochester</td><td>桑菲尔德庄园主人</td><td>简的爱人；伯莎的丈夫；阿黛尔的监护人</td></tr>
        <tr><td>伯莎·梅森 Bertha Mason</td><td>罗切斯特的疯妻子</td><td>被关在桑菲尔德三楼；纵火烧毁庄园</td></tr>
        <tr><td>里德太太 Mrs. Reed</td><td>简的舅妈</td><td>抚养简却虐待她；临终前未真心和解</td></tr>
        <tr><td>海伦·彭斯 Helen Burns</td><td>洛伍德学校学生</td><td>简的第一个朋友；因肺病早逝</td></tr>
        <tr><td>谭波儿小姐 Miss Temple</td><td>洛伍德学校教师/学监</td><td>信任简、为简洗清冤屈；对简影响深远</td></tr>
        <tr><td>勃洛克赫斯特 Mr. Brocklehurst</td><td>洛伍德学校司库</td><td>伪善苛刻；当众羞辱简</td></tr>
        <tr><td>圣约翰·里弗斯 St. John Rivers</td><td>牧师，简的表哥</td><td>收留简；向简求婚被拒；前往印度传教</td></tr>
        <tr><td>黛安娜 & 玛丽 Diana & Mary</td><td>圣约翰的妹妹，简的表姐</td><td>与简志趣相投；遗产受益人</td></tr>
        <tr><td>费尔法克斯太太 Mrs. Fairfax</td><td>桑菲尔德管家</td><td>善待简；性格平和善良</td></tr>
        <tr><td>阿黛尔 Adèle</td><td>罗切斯特的养女</td><td>简的学生；活泼可爱</td></tr>
      </tbody>
    </table>
  </section>

  <section class="quote-section">
    <h2>经典台词：原书里的那些名句</h2>

    <div class="quote-card">
      <div class="speaker">简·爱 Jane Eyre</div>
      <blockquote>“Do you think I am an automaton? — a machine without feelings? … Do you think, because I am poor, obscure, plain, and little, I am soulless and heartless? You think wrong! — I have as much soul as you, — and full as much heart!”</blockquote>
      <p class="trans">“你以为我是一架自动机器么？一架没有感情的机器么？……你以为，因为我穷、低微、不美、矮小，我就没有灵魂没有心了么？你想错了！——我的灵魂和你一样，我的心也完全跟你一样！”</p>
      <p class="note">全书最核心的宣言。简在罗切斯特面前不卑不亢，将爱情建立在灵魂平等之上。这句话之所以有力，不仅因为情感炽烈，更因为它来自一个在身份、财富、外貌上都处于绝对劣势的女性，却毫无乞怜之意。</p>
    </div>

    <div class="quote-card">
      <div class="speaker">简·爱 Jane Eyre</div>
      <blockquote>“I am not talking to you now through the medium of custom, conventionalities, nor even of mortal flesh; — it is my spirit that addresses your spirit; just as if both had passed through the grave, and we stood at God‘s feet, equal, — as we are!”</blockquote>
      <p class="trans">“我现在不是通过习俗、惯例，甚至不是通过凡人的肉体跟你说话——而是我的精神同你的精神说话；就像两个都经过了坟墓，我们站在上帝脚跟前，是平等的——因为我们是平等的！”</p>
      <p class="note">紧接前一句的收束。简把爱情从社会阶层的框架中抽离出来，放到“灵魂”与“上帝”面前重新定义。勃朗特借这句话宣告：真正的关系平等不取决于外部条件，而取决于双方是否以完整的精神相互面对。</p>
    </div>

    <div class="quote-card">
      <div class="speaker">海伦·彭斯 Helen Burns</div>
      <blockquote>“Life appears to me too short to be spent in nursing animosity or registering wrongs.”</blockquote>
      <p class="trans">“生命对我来说太短暂了，不能用来怀恨记仇。”</p>
      <p class="note">海伦在简因受罚而愤怒时说出这句话。它既是海伦宗教信仰的体现，也是她对简最深刻的劝导。简一生都在“反抗”与“宽恕”之间拉扯，海伦的这句话是她内心另一极的锚点。</p>
    </div>

    <div class="quote-card">
      <div class="speaker">罗切斯特 Mr. Rochester</div>
      <blockquote>“My bride is here, because my equal is here, and my likeness.”</blockquote>
      <p class="trans">“我的新娘在这里，因为我的平等者在这里，我的同类在这里。”</p>
      <p class="note">罗切斯特在简答应求婚后说的话。值得注意的是，他用的词是“equal”和“likeness”——不是“爱人”或“美人”。这句话呼应了简此前关于平等的宣言，表明他终于以简所要求的方式承认了她。</p>
    </div>

    <div class="quote-card">
      <div class="speaker">圣约翰·里弗斯 St. John Rivers</div>
      <blockquote>“God and nature intended you for a missionary’s wife.”</blockquote>
      <p class="trans">“上帝和自然注定你要做传教士的妻子。”</p>
      <p class="note">圣约翰向简求婚的理由。他以神意和“适合”取代爱情，把婚姻视为使命的工具。这句话精准地呈现了圣约翰的性格：虔诚、克制、令人敬畏，却缺乏温度。简的拒绝是对这种以责任压杀情感的婚姻观的否定。</p>
    </div>

    <div class="quote-card">
      <div class="speaker">叙述者 / 简·爱</div>
      <blockquote>“I could not help it: I worshipped him: and I could not help worshipping him, because I loved him.”</blockquote>
      <p class="trans">“我忍不住要崇拜他：我忍不住崇拜他，因为我爱他。”</p>
      <p class="note">简对自身情感的坦诚告白。一个从小被教导要克制、要忍耐、要低调的女性，在爱情面前毫不掩饰自己的感受。勃朗特让简同时拥有清醒的头脑和炽热的心，这正是这个人物两百年来始终动人的原因。</p>
    </div>
  </section>

  <footer>
    基于夏洛蒂·勃朗特《简·爱》通行文本整理 · 人物关系与引文仅供阅读参考
  </footer>

</div>

<script>
(function(){
  // 节点定义：id, 名称, 类型(central/love/family/conflict/friend), x, y
  const NODES = [
    { id:'jane',      label:'简·爱',        type:'central',  x:450, y:300 },
    { id:'rochester', label:'罗切斯特',      type:'love',     x:450, y:120 },
    { id:'bertha',    label:'伯莎·梅森',     type:'conflict', x:680, y:140 },
    { id:'reed',      label:'里德太太',      type:'conflict', x:210, y:170 },
    { id:'helen',     label:'海伦·彭斯',     type:'family',   x:150, y:340 },
    { id:'temple',    label:'谭波儿小姐',    type:'family',   x:140, y:470 },
    { id:'brockle',   label:'勃洛克赫斯特',  type:'conflict', x:260, y:500 },
    { id:'stjohn',    label:'圣约翰',        type:'family',   x:680, y:430 },
    { id:'sisters',   label:'黛安娜 & 玛丽', type:'family',   x:800, y:330 },
    { id:'fairfax',   label:'费尔法克斯太太',type:'friend',   x:650, y:540 },
    { id:'adele',     label:'阿黛尔',        type:'love',     x:300, y:90  }
  ];

  // 关系边：source, target, type, 关系描述
  const EDGES = [
    { s:'jane', t:'rochester', type:'love',     text:'相爱并最终结婚' },
    { s:'jane', t:'bertha',    type:'conflict', text:'伯莎是简婚礼被中断的原因' },
    { s:'jane', t:'reed',      type:'conflict', text:'童年受里德太太虐待' },
    { s:'jane', t:'helen',     type:'family',   text:'洛伍德学校的第一个朋友' },
    { s:'jane', t:'temple',    type:'family',   text:'谭波儿小姐信任并保护简' },
    { s:'jane', t:'brockle',   type:'conflict', text:'被当众羞辱为“说谎者”' },
    { s:'jane', t:'stjohn',    type:'family',   text:'表亲；圣约翰向简求婚被拒' },
    { s:'jane', t:'sisters',   type:'family',   text:'表姐，志趣相投' },
    { s:'jane', t:'fairfax',   type:'friend',   text:'桑菲尔德的管家，善待简' },
    { s:'jane', t:'adele',     type:'love',     text:'简是阿黛尔的家庭教师' },
    { s:'rochester', t:'bertha',  type:'conflict', text:'被隐藏的疯妻' },
    { s:'rochester', t:'adele',   type:'love',     text:'罗切斯特是阿黛尔的监护人' },
    { s:'rochester', t:'fairfax', type:'friend',   text:'主仆关系' },
    { s:'stjohn', t:'sisters',    type:'family',   text:'兄妹' },
    { s:'reed', t:'brockle',      type:'conflict', text:'里德太太将简送进洛伍德学校' },
    { s:'temple', t:'brockle',    type:'conflict', text:'同校共事，理念对立' }
  ];

  const svg = document.getElementById('chart');
  const NS = 'http://www.w3.org/2000/svg';
  const panel = document.getElementById('panel');

  const nodeMap = {};
  NODES.forEach(n => nodeMap[n.id] = n);

  const edgeLayer = document.createElementNS(NS,'g');
  const labelLayer = document.createElementNS(NS,'g');
  const nodeLayer = document.createElementNS(NS,'g');
  svg.appendChild(edgeLayer);
  svg.appendChild(labelLayer);
  svg.appendChild(nodeLayer);

  const edgeEls = [];
  const labelEls = [];

  // 绘制边
  EDGES.forEach((e, i) => {
    const a = nodeMap[e.s], b = nodeMap[e.t];
    if(!a || !b) return;
    const line = document.createElementNS(NS,'line');
    line.setAttribute('x1', a.x); line.setAttribute('y1', a.y);
    line.setAttribute('x2', b.x); line.setAttribute('y2', b.y);
    line.setAttribute('class', 'edge ' + e.type);
    line.dataset.index = i;
    edgeLayer.appendChild(line);
    edgeEls.push({ el:line, edge:e });

    const label = document.createElementNS(NS,'text');
    label.setAttribute('x', (a.x + b.x)/2);
    label.setAttribute('y', (a.y + b.y)/2 - 6);
    label.setAttribute('text-anchor','middle');
    label.setAttribute('class','edge-label');
    label.textContent = e.text;
    labelLayer.appendChild(label);
    labelEls.push({ el:label, edge:e });
  });

  // 绘制节点
  const nodeEls = {};
  NODES.forEach(n => {
    const g = document.createElementNS(NS,'g');
    g.setAttribute('class','node-group');
    g.dataset.id = n.id;

    const rect = document.createElementNS(NS,'rect');
    const w = 112, h = 38;
    rect.setAttribute('x', n.x - w/2);
    rect.setAttribute('y', n.y - h/2);
    rect.setAttribute('width', w);
    rect.setAttribute('height', h);
    rect.setAttribute('rx', 19);
    rect.setAttribute('ry', 19);
    rect.setAttribute('class','node-shape ' + n.type);
    g.appendChild(rect);

    const text = document.createElementNS(NS,'text');
    text.setAttribute('x', n.x);
    text.setAttribute('y', n.y + 4);
    text.setAttribute('class','node-label');
    text.textContent = n.label;
    g.appendChild(text);

    g.addEventListener('click', (ev) => {
      ev.stopPropagation();
      toggleNode(n.id);
    });

    nodeLayer.appendChild(g);
    nodeEls[n.id] = g;
  });

  let activeId = null;

  function clearAll(){
    activeId = null;
    edgeEls.forEach(o => { o.el.classList.remove('hl','dim'); });
    labelEls.forEach(o => { o.el.classList.remove('hl'); });
    Object.values(nodeEls).forEach(g => g.classList.remove('dim','active'));
    panel.innerHTML = '<span class="p-empty">点击上方任意人物，这里会列出他/她与其他人物的全部关系。</span>';
  }

  function toggleNode(id){
    if(activeId === id){ clearAll(); return; }
    activeId = id;
    const node = nodeMap[id];

    // 节点高亮/变暗
    Object.keys(nodeEls).forEach(nid => {
      const g = nodeEls[nid];
      g.classList.remove('dim','active');
      if(nid !== id) g.classList.add('dim');
    });
    nodeEls[id].classList.add('active');

    // 边与标签
    const related = [];
    edgeEls.forEach(o => {
      const e = o.edge;
      const isRel = (e.s === id || e.t === id);
      o.el.classList.remove('hl','dim');
      if(isRel){ o.el.classList.add('hl'); }
      else { o.el.classList.add('dim'); }
    });
    labelEls.forEach(o => {
      const e = o.edge;
      const isRel = (e.s === id || e.t === id);
      o.el.classList.toggle('hl', isRel);
      o.el.textContent = isRel ? e.text : '';
      if(isRel){
        related.push(e);
      }
    });

    // 取消关联节点变暗（已处理），但保证相关节点不变暗
    related.forEach(e => {
      const other = e.s === id ? e.t : e.s;
      if(nodeEls[other]) nodeEls[other].classList.remove('dim');
    });

    // 更新面板
    if(related.length === 0){
      panel.innerHTML = `<div class="p-title">${node.label}</div><div class="p-empty">该人物在图中没有列出的直接关系。</div>`;
    } else {
      const items = related.map(e => {
        const other = e.s === id ? e.t : e.s;
        const otherNode = nodeMap[other];
        const typeName = { love:'爱慕/婚恋', family:'亲属/友谊', conflict:'冲突/压迫', friend:'雇佣/照料' }[e.type];
        return `<li><b>${otherNode.label}</b>（${typeName}）：${e.text}</li>`;
      }).join('');
      panel.innerHTML = `<div class="p-title">${node.label} · 全部直接关系</div><ul>${items}</ul>`;
    }
  }

  // 点击空白取消
  svg.addEventListener('click', () => clearAll());

  // 支持键盘 Esc 取消
  document.addEventListener('keydown', (e) => { if(e.key === 'Escape') clearAll(); });
})();
</script>
</body>
</html><!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>简·爱 人物关系图 | Jane Eyre Character Map</title>
<style>
  * { margin:0; padding:0; box-sizing:border-box; }
  body {
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
    background:#f5f2eb; color:#2c2c2c; line-height:1.7; padding:40px 20px;
  }
  .container { max-width:1060px; margin:0 auto; }
  header { text-align:center; margin-bottom:40px; }
  header h1 { font-size:2.2rem; font-weight:700; letter-spacing:1px; color:#1a1a1a; }
  header .sub { font-size:.95rem; color:#7a6e5d; margin-top:8px; letter-spacing:.5px; }
  header .desc { font-size:.9rem; color:#8a7e6d; margin-top:6px; }

  .map-section {
    background:#fffdf8; border-radius:16px; padding:28px 20px 20px;
    box-shadow:0 2px 12px rgba(0,0,0,.05); margin-bottom:40px;
  }
  .map-section h2 { font-size:1.3rem; margin-bottom:6px; color:#3d3529; text-align:center; }
  .map-hint { font-size:.85rem; color:#9a8e7d; margin-bottom:14px; text-align:center; }

  /* SVG 关系图 */
  #chartWrap { position:relative; width:100%; overflow:hidden; }
  svg#chart { width:100%; height:auto; display:block; user-select:none; }

  .edge {
    stroke:#d9d0c0; stroke-width:1.6; fill:none;
    transition: stroke .25s, stroke-width .25s, opacity .25s;
  }
  .edge.dim { opacity:.12; }
  .edge.hl { stroke-width:3; }
  .edge.hl.love    { stroke:#c47a5a; }
  .edge.hl.family  { stroke:#8a9a7a; }
  .edge.hl.conflict{ stroke:#b85c5c; }
  .edge.hl.friend  { stroke:#6a8aaa; }

  .edge-label { font-size:11px; fill:#9a8e7d; opacity:0; transition:opacity .25s; pointer-events:none; }
  .edge-label.hl { opacity:1; }

  .node-group { cursor:pointer; }
  .node-shape {
    stroke-width:1.8;
    transition: fill .25s, stroke .25s, transform .25s, opacity .25s;
    transform-box: fill-box; transform-origin:center;
  }
  .node-label {
    font-size:12.5px; font-weight:600; fill:#3d3529; text-anchor:middle;
    pointer-events:none; transition: opacity .25s;
  }
  .node-group.dim { opacity:.18; }
  .node-group.active .node-shape { transform: scale(1.08); }
  .node-group:hover .node-shape { transform: scale(1.05); }

  .node-shape.central { fill:#3d3529; stroke:#3d3529; }
  .node-shape.central + .node-label { fill:#f5f2eb; }
  .node-shape.love     { fill:#fdf5f0; stroke:#c47a5a; }
  .node-shape.family   { fill:#f4f7f0; stroke:#8a9a7a; }
  .node-shape.conflict { fill:#fdf0f0; stroke:#b85c5c; }
  .node-shape.friend   { fill:#f0f4fa; stroke:#6a8aaa; }

  .legend {
    display:flex; flex-wrap:wrap; justify-content:center; gap:18px;
    font-size:.82rem; color:#7a6e5d; margin-top:14px;
  }
  .legend span::before {
    content:""; display:inline-block; width:10px; height:10px; border-radius:50%;
    margin-right:5px; vertical-align:middle;
  }
  .legend .l-love::before{background:#c47a5a;}
  .legend .l-family::before{background:#8a9a7a;}
  .legend .l-conflict::before{background:#b85c5c;}
  .legend .l-friend::before{background:#6a8aaa;}

  .map-note { font-size:.8rem; color:#9a8e7d; margin-top:14px; font-style:italic; text-align:center; }

  /* 关系解读面板 */
  #panel {
    margin-top:18px; background:#fffdf8; border:1px dashed #d9d0c0;
    border-radius:12px; padding:16px 20px; font-size:.9rem; color:#5a5040;
    min-height:70px; transition:opacity .3s;
  }
  #panel .p-title { font-weight:600; color:#3d3529; margin-bottom:6px; }
  #panel .p-empty { color:#b0a898; font-style:italic; }
  #panel ul { list-style:none; margin-top:6px; }
  #panel li { padding:3px 0; }
  #panel li::before { content:"—"; color:#c47a5a; margin-right:8px; }

  /* 关键关系 */
  .key-section { margin-bottom:40px; }
  .key-section h2 { font-size:1.3rem; margin-bottom:20px; color:#3d3529; }
  .rel-card {
    background:#fffdf8; border-left:4px solid #c47a5a; border-radius:8px;
    padding:20px 24px; margin-bottom:16px; box-shadow:0 1px 6px rgba(0,0,0,.04);
  }
  .rel-card:nth-child(2){border-left-color:#8a9a7a;}
  .rel-card:nth-child(3){border-left-color:#b85c5c;}
  .rel-card:nth-child(4){border-left-color:#6a8aaa;}
  .rel-card:nth-child(5){border-left-color:#9a7aaa;}
  .rel-card:nth-child(6){border-left-color:#b89a5a;}
  .rel-card .rel-title { font-size:1.05rem; font-weight:600; color:#2c2c2c; margin-bottom:8px; }
  .rel-card .rel-title span { font-weight:400; font-size:.85rem; color:#9a8e7d; margin-left:8px; }
  .rel-card p { font-size:.9rem; color:#5a5040; }

  /* 速查表 */
  .table-section { margin-bottom:40px; }
  .table-section h2 { font-size:1.3rem; margin-bottom:16px; color:#3d3529; }
  table {
    width:100%; border-collapse:collapse; background:#fffdf8;
    border-radius:10px; overflow:hidden; box-shadow:0 1px 6px rgba(0,0,0,.04);
    font-size:.88rem;
  }
  th { background:#3d3529; color:#f5f2eb; text-align:left; padding:12px 16px; font-weight:500; }
  td { padding:12px 16px; border-bottom:1px solid #ede8df; color:#4a4030; }
  tr:last-child td { border-bottom:none; }
  tr:hover td { background:#faf7f2; }

  /* 台词 */
  .quote-section { margin-bottom:20px; }
  .quote-section h2 { font-size:1.3rem; margin-bottom:20px; color:#3d3529; }
  .quote-card {
    background:#fffdf8; border-radius:10px; padding:20px 24px;
    margin-bottom:16px; box-shadow:0 1px 6px rgba(0,0,0,.04);
  }
  .quote-card .speaker { font-size:.85rem; font-weight:600; color:#c47a5a; margin-bottom:6px; letter-spacing:.5px; }
  .quote-card blockquote {
    font-size:.95rem; color:#3d3529; font-style:italic; margin-bottom:8px;
    padding-left:14px; border-left:2px solid #d9d0c0;
  }
  .quote-card .trans { font-size:.88rem; color:#6a6050; margin-bottom:8px; }
  .quote-card .note { font-size:.82rem; color:#9a8e7d; }

  footer { text-align:center; font-size:.78rem; color:#b0a898; margin-top:40px; padding-top:20px; border-top:1px solid #e5dfd5; }

  @media (max-width:600px){
    body{padding:24px 14px;}
    header h1{font-size:1.6rem;}
    .node-label{font-size:10px;}
    table{font-size:.78rem;}
    th,td{padding:8px 10px;}
    #panel{font-size:.85rem;}
  }
</style>
</head>
<body>
<div class="container">

  <header>
    <h1>简·爱 人物关系图</h1>
    <div class="sub">Jane Eyre · Charlotte Brontë</div>
    <div class="desc">十一位主要人物的亲属、婚恋、友谊与冲突关系</div>
  </header>

  <section class="map-section">
    <h2>一张图看懂主要人物关系</h2>
    <p class="map-hint">点击图中人物，高亮其全部关系；再次点击空白处取消</p>

    <div id="chartWrap">
      <svg id="chart" viewBox="0 0 900 620" aria-label="简·爱人物关系图"></svg>
    </div>

    <div class="legend">
      <span class="l-love">爱慕 / 婚恋</span>
      <span class="l-family">亲属 / 友谊</span>
      <span class="l-conflict">冲突 / 压迫</span>
      <span class="l-friend">雇佣 / 照料</span>
    </div>

    <p class="map-note">注：图中只呈现主要人物之间的直接关系；英格拉姆小姐、奥利弗小姐等次要人物未列入，以免图面过密。</p>

    <div id="panel"><span class="p-empty">点击上方任意人物，这里会列出他/她与其他人物的全部关系。</span></div>
  </section>

  <section class="key-section">
    <h2>六组关键关系逐条拆解</h2>

    <div class="rel-card">
      <div class="rel-title">主线婚恋 · 简 & 罗切斯特 <span>Jane & Rochester</span></div>
      <p>桑菲尔德庄园的家庭教师与庄园主人，身份悬殊却灵魂对等。简在罗切斯特面前始终保持独立与尊严，那句“我们的精神是平等的”成为全书的核心宣言。婚礼上被揭穿罗切斯特已有疯妻伯莎，简拒绝以情妇身份留下，毅然出走。历经流浪、继承遗产与伯莎纵火身亡后，简回到双目失明、右手残废的罗切斯特身边，两人终于在平等中结合。书名所指向的，正是简在爱情中绝不放弃的自尊与原则。</p>
    </div>

    <div class="rel-card">
      <div class="rel-title">童年压迫 · 简 & 里德太太一家 <span>Jane & the Reeds</span></div>
      <p>简幼年寄居舅妈里德太太家，受尽歧视与虐待。表哥约翰无故殴打她，反被舅妈关进“红房子”禁闭，那次惊吓成为她童年最深的创伤。面对不公，简没有选择逆来顺受，而是当面反抗，喊出“我不是骗子”。里德太太临终前仍不愿真心和解，但简最终选择原谅。这段经历塑造了简对尊严的极度敏感，也解释了她日后在任何关系中都不肯屈就的性格根源。</p>
    </div>

    <div class="rel-card">
      <div class="rel-title">精神友谊 · 简 & 海伦·彭斯 <span>Jane & Helen Burns</span></div>
      <p>洛伍德学校里，海伦是简的第一个朋友。面对勃洛克赫斯特的羞辱与校内的苛待，海伦以近乎圣徒般的忍耐与宽恕回应，与简本能的反抗形成鲜明对照。海伦告诉简“生命太短，不该用来记恨”，这句话深深影响了简。海伦因肺病早逝，简在睡梦中与她无声告别。海伦的信仰与温柔，是简内心柔软一面的来源，也让她在日后学会在反抗之外保留宽恕的能力。</p>
    </div>

    <div class="rel-card">
      <div class="rel-title">表亲与求婚 · 圣约翰 & 简 <span>St. John & Jane</span></div>
      <p>简流浪至沼泽居，被圣约翰兄妹收留，后得知彼此是表亲，并继承了叔叔留下的遗产。圣约翰是虔诚而冷峻的传教士，他向简求婚并非出于爱情，而是认为简适合做传教士的妻子、能协助他在印度的使命。简几乎被他的意志说服，但在最后一刻听到了罗切斯特的呼唤，拒绝了这桩没有爱情的婚姻。圣约翰代表了以责任和宗教之名压抑情感的另一种人生可能，简的拒绝则再次确认了她对真实情感的坚持。</p>
    </div>

    <div class="rel-card">
      <div class="rel-title">被隐藏的障碍 · 罗切斯特 & 伯莎·梅森 <span>Rochester & Bertha</span></div>
      <p>伯莎是罗切斯特在牙买加被安排的妻子，患有精神疾病，被关在桑菲尔德庄园三楼密室，由格雷斯·普尔看管。她的存在是罗切斯特痛苦与秘密的源头，也是简的婚礼被中断的直接原因。小说结尾，伯莎纵火烧毁桑菲尔德，自己跳楼身亡，罗切斯特为救她而失明残废。伯莎既是罗切斯特过往错误的化身，也是简与罗切斯特之间必须被清除的障碍，她的死使两人的结合在道德与法律上都成为可能。</p>
    </div>

    <div class="rel-card">
      <div class="rel-title">制度压迫 · 简 & 勃洛克赫斯特 <span>Jane & Mr. Brocklehurst</span></div>
      <p>勃洛克赫斯特是洛伍德学校的司库与实际管理者，以宗教之名行苛刻之实。他当众宣布简是“说谎者”，让她在全校面前罚站，并以此羞辱里德太太推荐来的孩子。他自家享受优渥生活，却要求学生们忍受饥饿与寒冷，是全书中最鲜明的伪善者形象。简后来在谭波儿小姐的帮助下洗清污名，而勃洛克赫斯特的虚伪也让她更清楚地看到，以权威面目出现的“正义”未必值得服从。</p>
    </div>
  </section>

  <section class="table-section">
    <h2>人物身份速查表</h2>
    <table>
      <thead>
        <tr><th>人物</th><th>身份</th><th>关键关系</th></tr>
      </thead>
      <tbody>
        <tr><td>简·爱 Jane Eyre</td><td>孤儿，家庭教师</td><td>罗切斯特的爱人；海伦的朋友；圣约翰的表妹</td></tr>
        <tr><td>爱德华·罗切斯特 Edward Rochester</td><td>桑菲尔德庄园主人</td><td>简的爱人；伯莎的丈夫；阿黛尔的监护人</td></tr>
        <tr><td>伯莎·梅森 Bertha Mason</td><td>罗切斯特的疯妻子</td><td>被关在桑菲尔德三楼；纵火烧毁庄园</td></tr>
        <tr><td>里德太太 Mrs. Reed</td><td>简的舅妈</td><td>抚养简却虐待她；临终前未真心和解</td></tr>
        <tr><td>海伦·彭斯 Helen Burns</td><td>洛伍德学校学生</td><td>简的第一个朋友；因肺病早逝</td></tr>
        <tr><td>谭波儿小姐 Miss Temple</td><td>洛伍德学校教师/学监</td><td>信任简、为简洗清冤屈；对简影响深远</td></tr>
        <tr><td>勃洛克赫斯特 Mr. Brocklehurst</td><td>洛伍德学校司库</td><td>伪善苛刻；当众羞辱简</td></tr>
        <tr><td>圣约翰·里弗斯 St. John Rivers</td><td>牧师，简的表哥</td><td>收留简；向简求婚被拒；前往印度传教</td></tr>
        <tr><td>黛安娜 & 玛丽 Diana & Mary</td><td>圣约翰的妹妹，简的表姐</td><td>与简志趣相投；遗产受益人</td></tr>
        <tr><td>费尔法克斯太太 Mrs. Fairfax</td><td>桑菲尔德管家</td><td>善待简；性格平和善良</td></tr>
        <tr><td>阿黛尔 Adèle</td><td>罗切斯特的养女</td><td>简的学生；活泼可爱</td></tr>
      </tbody>
    </table>
  </section>

  <section class="quote-section">
    <h2>经典台词：原书里的那些名句</h2>

    <div class="quote-card">
      <div class="speaker">简·爱 Jane Eyre</div>
      <blockquote>“Do you think I am an automaton? — a machine without feelings? … Do you think, because I am poor, obscure, plain, and little, I am soulless and heartless? You think wrong! — I have as much soul as you, — and full as much heart!”</blockquote>
      <p class="trans">“你以为我是一架自动机器么？一架没有感情的机器么？……你以为，因为我穷、低微、不美、矮小，我就没有灵魂没有心了么？你想错了！——我的灵魂和你一样，我的心也完全跟你一样！”</p>
      <p class="note">全书最核心的宣言。简在罗切斯特面前不卑不亢，将爱情建立在灵魂平等之上。这句话之所以有力，不仅因为情感炽烈，更因为它来自一个在身份、财富、外貌上都处于绝对劣势的女性，却毫无乞怜之意。</p>
    </div>

    <div class="quote-card">
      <div class="speaker">简·爱 Jane Eyre</div>
      <blockquote>“I am not talking to you now through the medium of custom, conventionalities, nor even of mortal flesh; — it is my spirit that addresses your spirit; just as if both had passed through the grave, and we stood at God‘s feet, equal, — as we are!”</blockquote>
      <p class="trans">“我现在不是通过习俗、惯例，甚至不是通过凡人的肉体跟你说话——而是我的精神同你的精神说话；就像两个都经过了坟墓，我们站在上帝脚跟前，是平等的——因为我们是平等的！”</p>
      <p class="note">紧接前一句的收束。简把爱情从社会阶层的框架中抽离出来，放到“灵魂”与“上帝”面前重新定义。勃朗特借这句话宣告：真正的关系平等不取决于外部条件，而取决于双方是否以完整的精神相互面对。</p>
    </div>

    <div class="quote-card">
      <div class="speaker">海伦·彭斯 Helen Burns</div>
      <blockquote>“Life appears to me too short to be spent in nursing animosity or registering wrongs.”</blockquote>
      <p class="trans">“生命对我来说太短暂了，不能用来怀恨记仇。”</p>
      <p class="note">海伦在简因受罚而愤怒时说出这句话。它既是海伦宗教信仰的体现，也是她对简最深刻的劝导。简一生都在“反抗”与“宽恕”之间拉扯，海伦的这句话是她内心另一极的锚点。</p>
    </div>

    <div class="quote-card">
      <div class="speaker">罗切斯特 Mr. Rochester</div>
      <blockquote>“My bride is here, because my equal is here, and my likeness.”</blockquote>
      <p class="trans">“我的新娘在这里，因为我的平等者在这里，我的同类在这里。”</p>
      <p class="note">罗切斯特在简答应求婚后说的话。值得注意的是，他用的词是“equal”和“likeness”——不是“爱人”或“美人”。这句话呼应了简此前关于平等的宣言，表明他终于以简所要求的方式承认了她。</p>
    </div>

    <div class="quote-card">
      <div class="speaker">圣约翰·里弗斯 St. John Rivers</div>
      <blockquote>“God and nature intended you for a missionary’s wife.”</blockquote>
      <p class="trans">“上帝和自然注定你要做传教士的妻子。”</p>
      <p class="note">圣约翰向简求婚的理由。他以神意和“适合”取代爱情，把婚姻视为使命的工具。这句话精准地呈现了圣约翰的性格：虔诚、克制、令人敬畏，却缺乏温度。简的拒绝是对这种以责任压杀情感的婚姻观的否定。</p>
    </div>

    <div class="quote-card">
      <div class="speaker">叙述者 / 简·爱</div>
      <blockquote>“I could not help it: I worshipped him: and I could not help worshipping him, because I loved him.”</blockquote>
      <p class="trans">“我忍不住要崇拜他：我忍不住崇拜他，因为我爱他。”</p>
      <p class="note">简对自身情感的坦诚告白。一个从小被教导要克制、要忍耐、要低调的女性，在爱情面前毫不掩饰自己的感受。勃朗特让简同时拥有清醒的头脑和炽热的心，这正是这个人物两百年来始终动人的原因。</p>
    </div>
  </section>

  <footer>
    基于夏洛蒂·勃朗特《简·爱》通行文本整理 · 人物关系与引文仅供阅读参考
  </footer>

</div>

<script>
(function(){
  // 节点定义：id, 名称, 类型(central/love/family/conflict/friend), x, y
  const NODES = [
    { id:'jane',      label:'简·爱',        type:'central',  x:450, y:300 },
    { id:'rochester', label:'罗切斯特',      type:'love',     x:450, y:120 },
    { id:'bertha',    label:'伯莎·梅森',     type:'conflict', x:680, y:140 },
    { id:'reed',      label:'里德太太',      type:'conflict', x:210, y:170 },
    { id:'helen',     label:'海伦·彭斯',     type:'family',   x:150, y:340 },
    { id:'temple',    label:'谭波儿小姐',    type:'family',   x:140, y:470 },
    { id:'brockle',   label:'勃洛克赫斯特',  type:'conflict', x:260, y:500 },
    { id:'stjohn',    label:'圣约翰',        type:'family',   x:680, y:430 },
    { id:'sisters',   label:'黛安娜 & 玛丽', type:'family',   x:800, y:330 },
    { id:'fairfax',   label:'费尔法克斯太太',type:'friend',   x:650, y:540 },
    { id:'adele',     label:'阿黛尔',        type:'love',     x:300, y:90  }
  ];

  // 关系边：source, target, type, 关系描述
  const EDGES = [
    { s:'jane', t:'rochester', type:'love',     text:'相爱并最终结婚' },
    { s:'jane', t:'bertha',    type:'conflict', text:'伯莎是简婚礼被中断的原因' },
    { s:'jane', t:'reed',      type:'conflict', text:'童年受里德太太虐待' },
    { s:'jane', t:'helen',     type:'family',   text:'洛伍德学校的第一个朋友' },
    { s:'jane', t:'temple',    type:'family',   text:'谭波儿小姐信任并保护简' },
    { s:'jane', t:'brockle',   type:'conflict', text:'被当众羞辱为“说谎者”' },
    { s:'jane', t:'stjohn',    type:'family',   text:'表亲；圣约翰向简求婚被拒' },
    { s:'jane', t:'sisters',   type:'family',   text:'表姐，志趣相投' },
    { s:'jane', t:'fairfax',   type:'friend',   text:'桑菲尔德的管家，善待简' },
    { s:'jane', t:'adele',     type:'love',     text:'简是阿黛尔的家庭教师' },
    { s:'rochester', t:'bertha',  type:'conflict', text:'被隐藏的疯妻' },
    { s:'rochester', t:'adele',   type:'love',     text:'罗切斯特是阿黛尔的监护人' },
    { s:'rochester', t:'fairfax', type:'friend',   text:'主仆关系' },
    { s:'stjohn', t:'sisters',    type:'family',   text:'兄妹' },
    { s:'reed', t:'brockle',      type:'conflict', text:'里德太太将简送进洛伍德学校' },
    { s:'temple', t:'brockle',    type:'conflict', text:'同校共事，理念对立' }
  ];

  const svg = document.getElementById('chart');
  const NS = 'http://www.w3.org/2000/svg';
  const panel = document.getElementById('panel');

  const nodeMap = {};
  NODES.forEach(n => nodeMap[n.id] = n);

  const edgeLayer = document.createElementNS(NS,'g');
  const labelLayer = document.createElementNS(NS,'g');
  const nodeLayer = document.createElementNS(NS,'g');
  svg.appendChild(edgeLayer);
  svg.appendChild(labelLayer);
  svg.appendChild(nodeLayer);

  const edgeEls = [];
  const labelEls = [];

  // 绘制边
  EDGES.forEach((e, i) => {
    const a = nodeMap[e.s], b = nodeMap[e.t];
    if(!a || !b) return;
    const line = document.createElementNS(NS,'line');
    line.setAttribute('x1', a.x); line.setAttribute('y1', a.y);
    line.setAttribute('x2', b.x); line.setAttribute('y2', b.y);
    line.setAttribute('class', 'edge ' + e.type);
    line.dataset.index = i;
    edgeLayer.appendChild(line);
    edgeEls.push({ el:line, edge:e });

    const label = document.createElementNS(NS,'text');
    label.setAttribute('x', (a.x + b.x)/2);
    label.setAttribute('y', (a.y + b.y)/2 - 6);
    label.setAttribute('text-anchor','middle');
    label.setAttribute('class','edge-label');
    label.textContent = e.text;
    labelLayer.appendChild(label);
    labelEls.push({ el:label, edge:e });
  });

  // 绘制节点
  const nodeEls = {};
  NODES.forEach(n => {
    const g = document.createElementNS(NS,'g');
    g.setAttribute('class','node-group');
    g.dataset.id = n.id;

    const rect = document.createElementNS(NS,'rect');
    const w = 112, h = 38;
    rect.setAttribute('x', n.x - w/2);
    rect.setAttribute('y', n.y - h/2);
    rect.setAttribute('width', w);
    rect.setAttribute('height', h);
    rect.setAttribute('rx', 19);
    rect.setAttribute('ry', 19);
    rect.setAttribute('class','node-shape ' + n.type);
    g.appendChild(rect);

    const text = document.createElementNS(NS,'text');
    text.setAttribute('x', n.x);
    text.setAttribute('y', n.y + 4);
    text.setAttribute('class','node-label');
    text.textContent = n.label;
    g.appendChild(text);

    g.addEventListener('click', (ev) => {
      ev.stopPropagation();
      toggleNode(n.id);
    });

    nodeLayer.appendChild(g);
    nodeEls[n.id] = g;
  });

  let activeId = null;

  function clearAll(){
    activeId = null;
    edgeEls.forEach(o => { o.el.classList.remove('hl','dim'); });
    labelEls.forEach(o => { o.el.classList.remove('hl'); });
    Object.values(nodeEls).forEach(g => g.classList.remove('dim','active'));
    panel.innerHTML = '<span class="p-empty">点击上方任意人物，这里会列出他/她与其他人物的全部关系。</span>';
  }

  function toggleNode(id){
    if(activeId === id){ clearAll(); return; }
    activeId = id;
    const node = nodeMap[id];

    // 节点高亮/变暗
    Object.keys(nodeEls).forEach(nid => {
      const g = nodeEls[nid];
      g.classList.remove('dim','active');
      if(nid !== id) g.classList.add('dim');
    });
    nodeEls[id].classList.add('active');

    // 边与标签
    const related = [];
    edgeEls.forEach(o => {
      const e = o.edge;
      const isRel = (e.s === id || e.t === id);
      o.el.classList.remove('hl','dim');
      if(isRel){ o.el.classList.add('hl'); }
      else { o.el.classList.add('dim'); }
    });
    labelEls.forEach(o => {
      const e = o.edge;
      const isRel = (e.s === id || e.t === id);
      o.el.classList.toggle('hl', isRel);
      o.el.textContent = isRel ? e.text : '';
      if(isRel){
        related.push(e);
      }
    });

    // 取消关联节点变暗（已处理），但保证相关节点不变暗
    related.forEach(e => {
      const other = e.s === id ? e.t : e.s;
      if(nodeEls[other]) nodeEls[other].classList.remove('dim');
    });

    // 更新面板
    if(related.length === 0){
      panel.innerHTML = `<div class="p-title">${node.label}</div><div class="p-empty">该人物在图中没有列出的直接关系。</div>`;
    } else {
      const items = related.map(e => {
        const other = e.s === id ? e.t : e.s;
        const otherNode = nodeMap[other];
        const typeName = { love:'爱慕/婚恋', family:'亲属/友谊', conflict:'冲突/压迫', friend:'雇佣/照料' }[e.type];
        return `<li><b>${otherNode.label}</b>（${typeName}）：${e.text}</li>`;
      }).join('');
      panel.innerHTML = `<div class="p-title">${node.label} · 全部直接关系</div><ul>${items}</ul>`;
    }
  }

  // 点击空白取消
  svg.addEventListener('click', () => clearAll());

  // 支持键盘 Esc 取消
  document.addEventListener('keydown', (e) => { if(e.key === 'Escape') clearAll(); });
})();
</script>
</body>
</html>
