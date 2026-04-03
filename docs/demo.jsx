import React, { useState, useEffect } from 'react';
import { BookOpen, CheckCircle, Calendar, MessageCircle, ChevronRight, ChevronLeft, RefreshCw, Volume2, ChevronDown, ChevronUp, Music, Edit3, Monitor, Users, Coffee, ArrowRight, Plus, X, Save } from 'lucide-react';

// DỮ LIỆU TỪ VỰNG KHỔNG LỒ (Suomen Mestari 1 - Kappale 1 đến 9)
// Mở rộng quy mô lớn: Bao phủ Động từ, Tính từ, Đồ vật, Động vật, Thiên nhiên, Quần áo, Cơ thể...
const initialVocabularyData = [
  // --- KAPPALE 1: Tervehdykset, Pronominit & Numerot ---
  { finnish: "Hei / Moi / Terve", pronunciation: "/hei / moi / ˈter.ve/", english: "Hello / Hi", vietnamese: "Xin chào", category: "Kappale 1: Tervehdykset" },
  { finnish: "Huomenta", pronunciation: "/ˈhuo.men.tɑ/", english: "Good morning", vietnamese: "Chào buổi sáng", category: "Kappale 1: Tervehdykset" },
  { finnish: "Päivää", pronunciation: "/ˈpæi.vææ/", english: "Good day / afternoon", vietnamese: "Chào buổi chiều", category: "Kappale 1: Tervehdykset" },
  { finnish: "Iltaa", pronunciation: "/ˈil.tɑɑ/", english: "Good evening", vietnamese: "Chào buổi tối", category: "Kappale 1: Tervehdykset" },
  { finnish: "Hyvää yötä", pronunciation: "/ˈhy.vææ ˈyø.tæ/", english: "Good night", vietnamese: "Chúc ngủ ngon", category: "Kappale 1: Tervehdykset" },
  { finnish: "Näkemiin", pronunciation: "/ˈnæ.ke.miin/", english: "Goodbye", vietnamese: "Tạm biệt", category: "Kappale 1: Tervehdykset" },
  { finnish: "Heippa / Moikka", pronunciation: "/ˈheip.pɑ / ˈmoik.kɑ/", english: "Bye", vietnamese: "Tạm biệt (Thân mật)", category: "Kappale 1: Tervehdykset" },
  { finnish: "Nähdään", pronunciation: "/ˈnæh.dææn/", english: "See you", vietnamese: "Hẹn gặp lại", category: "Kappale 1: Tervehdykset" },
  { finnish: "Kiitos", pronunciation: "/ˈkii.tos/", english: "Thank you", vietnamese: "Cảm ơn", category: "Kappale 1: Tervehdykset" },
  { finnish: "Ole hyvä", pronunciation: "/ˈo.le ˈhy.væ/", english: "You're welcome / Here you go", vietnamese: "Không có chi / Của bạn đây", category: "Kappale 1: Tervehdykset" },
  { finnish: "Anteeksi", pronunciation: "/ˈɑn.teek.si/", english: "Sorry / Excuse me", vietnamese: "Xin lỗi", category: "Kappale 1: Tervehdykset" },
  { finnish: "Tervetuloa", pronunciation: "/ˈter.ve.tu.lo.ɑ/", english: "Welcome", vietnamese: "Chào mừng", category: "Kappale 1: Tervehdykset" },
  { finnish: "Mitä kuuluu?", pronunciation: "/ˈmi.tæ ˈkuu.luu/", english: "How are you?", vietnamese: "Bạn khỏe không?", category: "Kappale 1: Tervehdykset" },
  { finnish: "Kiitos hyvää", pronunciation: "/ˈkii.tos ˈhy.vææ/", english: "Good, thank you", vietnamese: "Cảm ơn, tôi khỏe", category: "Kappale 1: Tervehdykset" },
  { finnish: "Entä sinulle?", pronunciation: "/ˈen.tæ ˈsi.nul.le/", english: "And you?", vietnamese: "Còn bạn thì sao?", category: "Kappale 1: Tervehdykset" },
  { finnish: "Minä", pronunciation: "/ˈmi.næ/", english: "I", vietnamese: "Tôi", category: "Kappale 1: Pronominit" },
  { finnish: "Sinä", pronunciation: "/ˈsi.næ/", english: "You", vietnamese: "Bạn", category: "Kappale 1: Pronominit" },
  { finnish: "Hän", pronunciation: "/hæn/", english: "He / She", vietnamese: "Anh ấy / Cô ấy", category: "Kappale 1: Pronominit" },
  { finnish: "Me", pronunciation: "/me/", english: "We", vietnamese: "Chúng tôi", category: "Kappale 1: Pronominit" },
  { finnish: "Te", pronunciation: "/te/", english: "You (plural)", vietnamese: "Các bạn", category: "Kappale 1: Pronominit" },
  { finnish: "He", pronunciation: "/he/", english: "They", vietnamese: "Họ", category: "Kappale 1: Pronominit" },
  { finnish: "Tämä", pronunciation: "/ˈtæ.mæ/", english: "This", vietnamese: "Cái này / Người này", category: "Kappale 1: Pronominit" },
  { finnish: "Tuo", pronunciation: "/tuo/", english: "That", vietnamese: "Cái đó / Người đó", category: "Kappale 1: Pronominit" },
  { finnish: "Se", pronunciation: "/se/", english: "It", vietnamese: "Nó", category: "Kappale 1: Pronominit" },
  { finnish: "Kuka", pronunciation: "/ˈku.kɑ/", english: "Who", vietnamese: "Ai", category: "Kappale 1: Kysymyssanat" },
  { finnish: "Mikä", pronunciation: "/ˈmi.kæ/", english: "What", vietnamese: "Cái gì", category: "Kappale 1: Kysymyssanat" },
  { finnish: "Miten", pronunciation: "/ˈmi.ten/", english: "How", vietnamese: "Như thế nào / Bằng cách nào", category: "Kappale 1: Kysymyssanat" },
  { finnish: "Nimi", pronunciation: "/ˈni.mi/", english: "Name", vietnamese: "Tên", category: "Kappale 1: Sanat" },
  { finnish: "Nolla", pronunciation: "/ˈnol.lɑ/", english: "Zero", vietnamese: "Số không", category: "Kappale 1: Numerot" },
  { finnish: "Yksi", pronunciation: "/ˈyk.si/", english: "One", vietnamese: "Một", category: "Kappale 1: Numerot" },
  { finnish: "Kaksi", pronunciation: "/ˈkɑk.si/", english: "Two", vietnamese: "Hai", category: "Kappale 1: Numerot" },
  { finnish: "Kolme", pronunciation: "/ˈkol.me/", english: "Three", vietnamese: "Ba", category: "Kappale 1: Numerot" },
  { finnish: "Neljä", pronunciation: "/ˈnel.jæ/", english: "Four", vietnamese: "Bốn", category: "Kappale 1: Numerot" },
  { finnish: "Viisi", pronunciation: "/ˈvii.si/", english: "Five", vietnamese: "Năm", category: "Kappale 1: Numerot" },
  { finnish: "Kuusi", pronunciation: "/ˈkuu.si/", english: "Six", vietnamese: "Sáu", category: "Kappale 1: Numerot" },
  { finnish: "Seitsemän", pronunciation: "/ˈseit.se.mæn/", english: "Seven", vietnamese: "Bảy", category: "Kappale 1: Numerot" },
  { finnish: "Kahdeksan", pronunciation: "/ˈkɑh.dek.sɑn/", english: "Eight", vietnamese: "Tám", category: "Kappale 1: Numerot" },
  { finnish: "Yhdeksän", pronunciation: "/ˈyh.dek.sæn/", english: "Nine", vietnamese: "Chín", category: "Kappale 1: Numerot" },
  { finnish: "Kymmenen", pronunciation: "/ˈkym.me.nen/", english: "Ten", vietnamese: "Mười", category: "Kappale 1: Numerot" },

  // --- KAPPALE 2: Maat, Kansalaisuudet, Kielet, Ammatit & Numerot 11-1000 ---
  { finnish: "Suomi", pronunciation: "/ˈsuo.mi/", english: "Finland", vietnamese: "Phần Lan", category: "Kappale 2: Maat" },
  { finnish: "Ruotsi", pronunciation: "/ˈruot.si/", english: "Sweden", vietnamese: "Thụy Điển", category: "Kappale 2: Maat" },
  { finnish: "Norja", pronunciation: "/ˈnor.jɑ/", english: "Norway", vietnamese: "Na Uy", category: "Kappale 2: Maat" },
  { finnish: "Tanska", pronunciation: "/ˈtɑns.kɑ/", english: "Denmark", vietnamese: "Đan Mạch", category: "Kappale 2: Maat" },
  { finnish: "Islanti", pronunciation: "/ˈis.lɑn.ti/", english: "Iceland", vietnamese: "Iceland", category: "Kappale 2: Maat" },
  { finnish: "Venäjä", pronunciation: "/ˈve.næ.jæ/", english: "Russia", vietnamese: "Nga", category: "Kappale 2: Maat" },
  { finnish: "Viro", pronunciation: "/ˈvi.ro/", english: "Estonia", vietnamese: "Estonia", category: "Kappale 2: Maat" },
  { finnish: "Englanti", pronunciation: "/ˈeŋ.lɑn.ti/", english: "England", vietnamese: "Anh", category: "Kappale 2: Maat" },
  { finnish: "Saksa", pronunciation: "/ˈsɑk.sɑ/", english: "Germany", vietnamese: "Đức", category: "Kappale 2: Maat" },
  { finnish: "Ranska", pronunciation: "/ˈrɑns.kɑ/", english: "France", vietnamese: "Pháp", category: "Kappale 2: Maat" },
  { finnish: "Espanja", pronunciation: "/ˈes.pɑn.jɑ/", english: "Spain", vietnamese: "Tây Ban Nha", category: "Kappale 2: Maat" },
  { finnish: "Italia", pronunciation: "/ˈi.tɑ.li.ɑ/", english: "Italy", vietnamese: "Ý", category: "Kappale 2: Maat" },
  { finnish: "Kreikka", pronunciation: "/ˈkreik.kɑ/", english: "Greece", vietnamese: "Hy Lạp", category: "Kappale 2: Maat" },
  { finnish: "Turkki", pronunciation: "/ˈturk.ki/", english: "Turkey", vietnamese: "Thổ Nhĩ Kỳ", category: "Kappale 2: Maat" },
  { finnish: "Yhdysvallat", pronunciation: "/ˈyh.dys.vɑl.lɑt/", english: "USA", vietnamese: "Mỹ", category: "Kappale 2: Maat" },
  { finnish: "Kiina", pronunciation: "/ˈkii.nɑ/", english: "China", vietnamese: "Trung Quốc", category: "Kappale 2: Maat" },
  { finnish: "Japani", pronunciation: "/ˈjɑ.pɑ.ni/", english: "Japan", vietnamese: "Nhật Bản", category: "Kappale 2: Maat" },
  { finnish: "Thaimaa", pronunciation: "/ˈthɑi.mɑɑ/", english: "Thailand", vietnamese: "Thái Lan", category: "Kappale 2: Maat" },
  { finnish: "Vietnam", pronunciation: "/ˈvi.et.nɑm/", english: "Vietnam", vietnamese: "Việt Nam", category: "Kappale 2: Maat" },
  { finnish: "Maa", pronunciation: "/mɑɑ/", english: "Country", vietnamese: "Quốc gia", category: "Kappale 2: Sanat" },
  { finnish: "Kaupunki", pronunciation: "/ˈkɑu.puŋ.ki/", english: "City", vietnamese: "Thành phố", category: "Kappale 2: Sanat" },
  { finnish: "Kieli", pronunciation: "/ˈkie.li/", english: "Language", vietnamese: "Ngôn ngữ", category: "Kappale 2: Kielet" },
  { finnish: "Suomalainen", pronunciation: "/ˈsuo.mɑ.lɑi.nen/", english: "Finnish (person)", vietnamese: "Người Phần Lan", category: "Kappale 2: Kansalaisuus" },
  { finnish: "Ammatti", pronunciation: "/ˈɑm.mɑt.ti/", english: "Profession", vietnamese: "Nghề nghiệp", category: "Kappale 2: Ammatit" },
  { finnish: "Opettaja", pronunciation: "/ˈo.pet.tɑ.jɑ/", english: "Teacher", vietnamese: "Giáo viên", category: "Kappale 2: Ammatit" },
  { finnish: "Opiskelija", pronunciation: "/ˈo.pis.ke.li.jɑ/", english: "Student", vietnamese: "Học sinh/Sinh viên", category: "Kappale 2: Ammatit" },
  { finnish: "Lääkäri", pronunciation: "/ˈlææ.kæ.ri/", english: "Doctor", vietnamese: "Bác sĩ", category: "Kappale 2: Ammatit" },
  { finnish: "Sairaanhoitaja", pronunciation: "/ˈsɑi.rɑɑn.hoi.tɑ.jɑ/", english: "Nurse", vietnamese: "Y tá", category: "Kappale 2: Ammatit" },
  { finnish: "Insinööri", pronunciation: "/ˈin.si.nøø.ri/", english: "Engineer", vietnamese: "Kỹ sư", category: "Kappale 2: Ammatit" },
  { finnish: "Myyjä", pronunciation: "/ˈmyy.jæ/", english: "Salesperson", vietnamese: "Nhân viên bán hàng", category: "Kappale 2: Ammatit" },
  { finnish: "Tarjoilija", pronunciation: "/ˈtɑr.joi.li.jɑ/", english: "Waiter/Waitress", vietnamese: "Bồi bàn", category: "Kappale 2: Ammatit" },
  { finnish: "Kokki", pronunciation: "/ˈkok.ki/", english: "Chef / Cook", vietnamese: "Đầu bếp", category: "Kappale 2: Ammatit" },
  { finnish: "Poliisi", pronunciation: "/ˈpo.lii.si/", english: "Police", vietnamese: "Cảnh sát", category: "Kappale 2: Ammatit" },
  { finnish: "Kampaaja", pronunciation: "/ˈkɑm.pɑɑ.jɑ/", english: "Hairdresser", vietnamese: "Thợ làm tóc", category: "Kappale 2: Ammatit" },
  { finnish: "Siivooja", pronunciation: "/ˈsii.voo.jɑ/", english: "Cleaner", vietnamese: "Lao công", category: "Kappale 2: Ammatit" },
  { finnish: "Kuljettaja", pronunciation: "/ˈkul.jet.tɑ.jɑ/", english: "Driver", vietnamese: "Tài xế", category: "Kappale 2: Ammatit" },
  { finnish: "Sihteeri", pronunciation: "/ˈsih.tee.ri/", english: "Secretary", vietnamese: "Thư ký", category: "Kappale 2: Ammatit" },
  { finnish: "Johtaja", pronunciation: "/ˈjoh.tɑ.jɑ/", english: "Manager / Director", vietnamese: "Giám đốc / Quản lý", category: "Kappale 2: Ammatit" },
  { finnish: "Koodari", pronunciation: "/ˈkoo.dɑ.ri/", english: "Coder / Programmer", vietnamese: "Lập trình viên", category: "Kappale 2: Ammatit" },
  { finnish: "Puhua", pronunciation: "/ˈpu.hu.ɑ/", english: "To speak", vietnamese: "Nói", category: "Kappale 2: Verbit" },
  { finnish: "Asua", pronunciation: "/ˈɑ.su.ɑ/", english: "To live (reside)", vietnamese: "Sinh sống", category: "Kappale 2: Verbit" },
  { finnish: "Olla kotoisin", pronunciation: "/ˈol.lɑ ˈko.toi.sin/", english: "To be from", vietnamese: "Đến từ", category: "Kappale 2: Verbit" },
  { finnish: "Mistä", pronunciation: "/ˈmis.tæ/", english: "From where", vietnamese: "Từ đâu", category: "Kappale 2: Kysymyssanat" },
  { finnish: "Missä", pronunciation: "/ˈmis.sæ/", english: "Where", vietnamese: "Ở đâu", category: "Kappale 2: Kysymyssanat" },
  { finnish: "Yksitoista", pronunciation: "/ˈyk.si.tois.tɑ/", english: "Eleven", vietnamese: "Mười một", category: "Kappale 2: Numerot" },
  { finnish: "Kaksitoista", pronunciation: "/ˈkɑk.si.tois.tɑ/", english: "Twelve", vietnamese: "Mười hai", category: "Kappale 2: Numerot" },
  { finnish: "Kolmetoista", pronunciation: "/ˈkol.me.tois.tɑ/", english: "Thirteen", vietnamese: "Mười ba", category: "Kappale 2: Numerot" },
  { finnish: "Kaksikymmentä", pronunciation: "/ˈkɑk.si.kym.men.tæ/", english: "Twenty", vietnamese: "Hai mươi", category: "Kappale 2: Numerot" },
  { finnish: "Kolmekymmentä", pronunciation: "/ˈkol.me.kym.men.tæ/", english: "Thirty", vietnamese: "Ba mươi", category: "Kappale 2: Numerot" },
  { finnish: "Sata", pronunciation: "/ˈsɑ.tɑ/", english: "Hundred", vietnamese: "Một trăm", category: "Kappale 2: Numerot" },
  { finnish: "Tuhat", pronunciation: "/ˈtu.hɑt/", english: "Thousand", vietnamese: "Một nghìn", category: "Kappale 2: Numerot" },

  // --- KAPPALE 3: Sää, Vuodenajat, Kuukaudet, Värit & Adjektiivit ---
  { finnish: "Sää / Ilma", pronunciation: "/sææ / ˈil.mɑ/", english: "Weather", vietnamese: "Thời tiết", category: "Kappale 3: Sää" },
  { finnish: "Aurinko paistaa", pronunciation: "/ˈɑu.rin.ko ˈpɑis.tɑɑ/", english: "The sun is shining", vietnamese: "Trời nắng", category: "Kappale 3: Sää" },
  { finnish: "Sataa vettä", pronunciation: "/ˈsɑ.tɑɑ ˈvet.tæ/", english: "It is raining", vietnamese: "Trời mưa", category: "Kappale 3: Sää" },
  { finnish: "Sataa lunta", pronunciation: "/ˈsɑ.tɑɑ ˈlun.tɑ/", english: "It is snowing", vietnamese: "Tuyết rơi", category: "Kappale 3: Sää" },
  { finnish: "Sataa rakeita", pronunciation: "/ˈsɑ.tɑɑ ˈrɑ.kei.tɑ/", english: "It is hailing", vietnamese: "Mưa đá", category: "Kappale 3: Sää" },
  { finnish: "Tuulee", pronunciation: "/ˈtuu.lee/", english: "It is windy", vietnamese: "Trời gió", category: "Kappale 3: Sää" },
  { finnish: "Pilvistä", pronunciation: "/ˈpil.vis.tæ/", english: "Cloudy", vietnamese: "Nhiều mây", category: "Kappale 3: Sää" },
  { finnish: "Ukkonen", pronunciation: "/ˈuk.ko.nen/", english: "Thunder", vietnamese: "Sấm chớp", category: "Kappale 3: Sää" },
  { finnish: "Sumu", pronunciation: "/ˈsu.mu/", english: "Fog", vietnamese: "Sương mù", category: "Kappale 3: Sää" },
  { finnish: "Aste", pronunciation: "/ˈɑs.te/", english: "Degree (temperature)", vietnamese: "Độ", category: "Kappale 3: Sää" },
  { finnish: "Kuuma", pronunciation: "/ˈkuu.mɑ/", english: "Hot", vietnamese: "Nóng", category: "Kappale 3: Adjektiivit" },
  { finnish: "Lämmin", pronunciation: "/ˈlæm.min/", english: "Warm", vietnamese: "Ấm áp", category: "Kappale 3: Adjektiivit" },
  { finnish: "Viileä", pronunciation: "/ˈvii.le.æ/", english: "Cool", vietnamese: "Mát mẻ", category: "Kappale 3: Adjektiivit" },
  { finnish: "Kylmä", pronunciation: "/ˈkyl.mæ/", english: "Cold", vietnamese: "Lạnh", category: "Kappale 3: Adjektiivit" },
  { finnish: "Pakkanen", pronunciation: "/ˈpɑk.kɑ.nen/", english: "Freezing weather", vietnamese: "Trời băng giá", category: "Kappale 3: Sää" },
  { finnish: "Kevät", pronunciation: "/ˈke.væt/", english: "Spring", vietnamese: "Mùa xuân", category: "Kappale 3: Vuodenajat" },
  { finnish: "Kesä", pronunciation: "/ˈke.sæ/", english: "Summer", vietnamese: "Mùa hè", category: "Kappale 3: Vuodenajat" },
  { finnish: "Syksy", pronunciation: "/ˈsyk.sy/", english: "Autumn / Fall", vietnamese: "Mùa thu", category: "Kappale 3: Vuodenajat" },
  { finnish: "Talvi", pronunciation: "/ˈtɑl.vi/", english: "Winter", vietnamese: "Mùa đông", category: "Kappale 3: Vuodenajat" },
  { finnish: "Tammikuu", pronunciation: "/ˈtɑm.mi.kuu/", english: "January", vietnamese: "Tháng một", category: "Kappale 3: Kuukaudet" },
  { finnish: "Helmikuu", pronunciation: "/ˈhel.mi.kuu/", english: "February", vietnamese: "Tháng hai", category: "Kappale 3: Kuukaudet" },
  { finnish: "Maaliskuu", pronunciation: "/ˈmɑɑ.lis.kuu/", english: "March", vietnamese: "Tháng ba", category: "Kappale 3: Kuukaudet" },
  { finnish: "Huhtikuu", pronunciation: "/ˈhuh.ti.kuu/", english: "April", vietnamese: "Tháng tư", category: "Kappale 3: Kuukaudet" },
  { finnish: "Toukokuu", pronunciation: "/ˈtou.ko.kuu/", english: "May", vietnamese: "Tháng năm", category: "Kappale 3: Kuukaudet" },
  { finnish: "Kesäkuu", pronunciation: "/ˈke.sæ.kuu/", english: "June", vietnamese: "Tháng sáu", category: "Kappale 3: Kuukaudet" },
  { finnish: "Heinäkuu", pronunciation: "/ˈhei.næ.kuu/", english: "July", vietnamese: "Tháng bảy", category: "Kappale 3: Kuukaudet" },
  { finnish: "Elokuu", pronunciation: "/ˈe.lo.kuu/", english: "August", vietnamese: "Tháng tám", category: "Kappale 3: Kuukaudet" },
  { finnish: "Syyskuu", pronunciation: "/ˈsyys.kuu/", english: "September", vietnamese: "Tháng chín", category: "Kappale 3: Kuukaudet" },
  { finnish: "Lokakuu", pronunciation: "/ˈlo.kɑ.kuu/", english: "October", vietnamese: "Tháng mười", category: "Kappale 3: Kuukaudet" },
  { finnish: "Marraskuu", pronunciation: "/ˈmɑr.rɑs.kuu/", english: "November", vietnamese: "Tháng mười một", category: "Kappale 3: Kuukaudet" },
  { finnish: "Joulukuu", pronunciation: "/ˈjou.lu.kuu/", english: "December", vietnamese: "Tháng mười hai", category: "Kappale 3: Kuukaudet" },
  { finnish: "Millainen", pronunciation: "/ˈmil.lɑi.nen/", english: "What kind of", vietnamese: "Như thế nào (Loại gì)", category: "Kappale 3: Kysymyssanat" },
  { finnish: "Väri", pronunciation: "/ˈvæ.ri/", english: "Color", vietnamese: "Màu sắc", category: "Kappale 3: Värit" },
  { finnish: "Valkoinen", pronunciation: "/ˈvɑl.koi.nen/", english: "White", vietnamese: "Màu trắng", category: "Kappale 3: Värit" },
  { finnish: "Musta", pronunciation: "/ˈmus.tɑ/", english: "Black", vietnamese: "Màu đen", category: "Kappale 3: Värit" },
  { finnish: "Punainen", pronunciation: "/ˈpu.nɑi.nen/", english: "Red", vietnamese: "Màu đỏ", category: "Kappale 3: Värit" },
  { finnish: "Sininen", pronunciation: "/ˈsi.ni.nen/", english: "Blue", vietnamese: "Màu xanh dương", category: "Kappale 3: Värit" },
  { finnish: "Vihreä", pronunciation: "/ˈvih.re.æ/", english: "Green", vietnamese: "Màu xanh lá", category: "Kappale 3: Värit" },
  { finnish: "Keltainen", pronunciation: "/ˈkel.tɑi.nen/", english: "Yellow", vietnamese: "Màu vàng", category: "Kappale 3: Värit" },
  { finnish: "Oranssi", pronunciation: "/ˈo.rɑns.si/", english: "Orange", vietnamese: "Màu cam", category: "Kappale 3: Värit" },
  { finnish: "Harmaa", pronunciation: "/ˈhɑr.mɑɑ/", english: "Grey", vietnamese: "Màu xám", category: "Kappale 3: Värit" },
  { finnish: "Ruskea", pronunciation: "/ˈrus.ke.ɑ/", english: "Brown", vietnamese: "Màu nâu", category: "Kappale 3: Värit" },
  { finnish: "Vaaleanpunainen", pronunciation: "/ˈvɑɑ.le.ɑn.pu.nɑi.nen/", english: "Pink", vietnamese: "Màu hồng", category: "Kappale 3: Värit" },
  { finnish: "Turkoosi", pronunciation: "/ˈtur.koo.si/", english: "Turquoise", vietnamese: "Màu ngọc lam", category: "Kappale 3: Värit" },
  { finnish: "Violetti", pronunciation: "/ˈvi.o.let.ti/", english: "Purple", vietnamese: "Màu tím", category: "Kappale 3: Värit" },
  { finnish: "Iso", pronunciation: "/ˈi.so/", english: "Big", vietnamese: "To / Lớn", category: "Kappale 3: Adjektiivit" },
  { finnish: "Pieni", pronunciation: "/ˈpie.ni/", english: "Small", vietnamese: "Nhỏ / Bé", category: "Kappale 3: Adjektiivit" },
  { finnish: "Uusi", pronunciation: "/ˈuu.si/", english: "New", vietnamese: "Mới", category: "Kappale 3: Adjektiivit" },
  { finnish: "Vanha", pronunciation: "/ˈvɑn.hɑ/", english: "Old", vietnamese: "Cũ / Già", category: "Kappale 3: Adjektiivit" },
  { finnish: "Hyvä", pronunciation: "/ˈhy.væ/", english: "Good", vietnamese: "Tốt / Hay / Ngon", category: "Kappale 3: Adjektiivit" },
  { finnish: "Huono", pronunciation: "/ˈhuo.no/", english: "Bad", vietnamese: "Xấu / Tồi", category: "Kappale 3: Adjektiivit" },
  { finnish: "Halpa", pronunciation: "/ˈhɑl.pɑ/", english: "Cheap", vietnamese: "Rẻ", category: "Kappale 3: Adjektiivit" },
  { finnish: "Kallis", pronunciation: "/ˈkɑl.lis/", english: "Expensive", vietnamese: "Đắt", category: "Kappale 3: Adjektiivit" },
  { finnish: "Helppo", pronunciation: "/ˈhelp.po/", english: "Easy", vietnamese: "Dễ dàng", category: "Kappale 3: Adjektiivit" },
  { finnish: "Vaikea", pronunciation: "/ˈvɑi.ke.ɑ/", english: "Difficult", vietnamese: "Khó khăn", category: "Kappale 3: Adjektiivit" },
  { finnish: "Oikea", pronunciation: "/ˈoi.ke.ɑ/", english: "Right / Correct", vietnamese: "Đúng / Bên phải", category: "Kappale 3: Adjektiivit" },
  { finnish: "Väärä", pronunciation: "/ˈvææ.ræ/", english: "Wrong", vietnamese: "Sai", category: "Kappale 3: Adjektiivit" },
  { finnish: "Puhdas", pronunciation: "/ˈpuh.dɑs/", english: "Clean", vietnamese: "Sạch sẽ", category: "Kappale 3: Adjektiivit" },
  { finnish: "Likainen", pronunciation: "/ˈli.kɑi.nen/", english: "Dirty", vietnamese: "Dơ bẩn", category: "Kappale 3: Adjektiivit" },
  { finnish: "Kova", pronunciation: "/ˈko.vɑ/", english: "Hard", vietnamese: "Cứng / Khó", category: "Kappale 3: Adjektiivit" },
  { finnish: "Pehmeä", pronunciation: "/ˈpeh.me.æ/", english: "Soft", vietnamese: "Mềm mại", category: "Kappale 3: Adjektiivit" },
  { finnish: "Raskas", pronunciation: "/ˈrɑs.kɑs/", english: "Heavy", vietnamese: "Nặng", category: "Kappale 3: Adjektiivit" },
  { finnish: "Kevyt", pronunciation: "/ˈke.vyt/", english: "Light", vietnamese: "Nhẹ", category: "Kappale 3: Adjektiivit" },

  // --- KAPPALE 4: Kello, Päivärytmi, Laajat Verbit ---
  { finnish: "Kello", pronunciation: "/ˈkel.lo/", english: "Clock / Time", vietnamese: "Đồng hồ / Giờ", category: "Kappale 4: Aika" },
  { finnish: "Tunti", pronunciation: "/ˈtun.ti/", english: "Hour", vietnamese: "Giờ (thời lượng)", category: "Kappale 4: Aika" },
  { finnish: "Minuutti", pronunciation: "/ˈmi.nuut.ti/", english: "Minute", vietnamese: "Phút", category: "Kappale 4: Aika" },
  { finnish: "Sekunti", pronunciation: "/ˈse.kun.ti/", english: "Second", vietnamese: "Giây", category: "Kappale 4: Aika" },
  { finnish: "Puoli", pronunciation: "/ˈpuo.li/", english: "Half", vietnamese: "Một nửa / Giờ rưỡi", category: "Kappale 4: Kello" },
  { finnish: "Varttia vaille", pronunciation: "/ˈvɑrt.ti.ɑ ˈvɑil.le/", english: "Quarter to", vietnamese: "Kém 15 phút", category: "Kappale 4: Kello" },
  { finnish: "Varttia yli", pronunciation: "/ˈvɑrt.ti.ɑ ˈy.li/", english: "Quarter past", vietnamese: "Hơn 15 phút", category: "Kappale 4: Kello" },
  { finnish: "Tasan", pronunciation: "/ˈtɑ.sɑn/", english: "Exactly", vietnamese: "Tròn / Đúng (giờ)", category: "Kappale 4: Kello" },
  { finnish: "Aamu", pronunciation: "/ˈɑɑ.mu/", english: "Morning", vietnamese: "Buổi sáng", category: "Kappale 4: Vuorokausi" },
  { finnish: "Aamupäivä", pronunciation: "/ˈɑɑ.mu.pæi.væ/", english: "Late morning", vietnamese: "Gần trưa", category: "Kappale 4: Vuorokausi" },
  { finnish: "Päivä", pronunciation: "/ˈpæi.væ/", english: "Day", vietnamese: "Ban ngày", category: "Kappale 4: Vuorokausi" },
  { finnish: "Iltapäivä", pronunciation: "/ˈil.tɑ.pæi.væ/", english: "Afternoon", vietnamese: "Buổi chiều", category: "Kappale 4: Vuorokausi" },
  { finnish: "Ilta", pronunciation: "/ˈil.tɑ/", english: "Evening", vietnamese: "Buổi tối", category: "Kappale 4: Vuorokausi" },
  { finnish: "Yö", pronunciation: "/yø/", english: "Night", vietnamese: "Ban đêm", category: "Kappale 4: Vuorokausi" },
  { finnish: "Maanantai", pronunciation: "/ˈmɑɑ.nɑn.tɑi/", english: "Monday", vietnamese: "Thứ Hai", category: "Kappale 4: Viikonpäivät" },
  { finnish: "Tiistai", pronunciation: "/ˈtiis.tɑi/", english: "Tuesday", vietnamese: "Thứ Ba", category: "Kappale 4: Viikonpäivät" },
  { finnish: "Keskiviikko", pronunciation: "/ˈkes.ki.viik.ko/", english: "Wednesday", vietnamese: "Thứ Tư", category: "Kappale 4: Viikonpäivät" },
  { finnish: "Torstai", pronunciation: "/ˈtors.tɑi/", english: "Thursday", vietnamese: "Thứ Năm", category: "Kappale 4: Viikonpäivät" },
  { finnish: "Perjantai", pronunciation: "/ˈper.jɑn.tɑi/", english: "Friday", vietnamese: "Thứ Sáu", category: "Kappale 4: Viikonpäivät" },
  { finnish: "Lauantai", pronunciation: "/ˈlɑu.ɑn.tɑi/", english: "Saturday", vietnamese: "Thứ Bảy", category: "Kappale 4: Viikonpäivät" },
  { finnish: "Sunnuntai", pronunciation: "/ˈsun.nun.tɑi/", english: "Sunday", vietnamese: "Chủ Nhật", category: "Kappale 4: Viikonpäivät" },
  { finnish: "Herätä", pronunciation: "/ˈhe.ræ.tæ/", english: "To wake up", vietnamese: "Thức dậy", category: "Kappale 4: Verbit (Päivärytmi)" },
  { finnish: "Nousta", pronunciation: "/ˈnous.tɑ/", english: "To get up", vietnamese: "Ngồi dậy / Đứng lên", category: "Kappale 4: Verbit (Päivärytmi)" },
  { finnish: "Käydä suihkussa", pronunciation: "/ˈkæy.dæ ˈsuih.kus.sɑ/", english: "To take a shower", vietnamese: "Đi tắm", category: "Kappale 4: Verbit (Päivärytmi)" },
  { finnish: "Pestä", pronunciation: "/ˈpes.tæ/", english: "To wash", vietnamese: "Rửa / Giặt", category: "Kappale 4: Verbit (Päivärytmi)" },
  { finnish: "Harjata hampaat", pronunciation: "/ˈhɑr.jɑ.tɑ ˈhɑm.pɑɑt/", english: "To brush teeth", vietnamese: "Đánh răng", category: "Kappale 4: Verbit (Päivärytmi)" },
  { finnish: "Pukeutua", pronunciation: "/ˈpu.keu.tu.ɑ/", english: "To get dressed", vietnamese: "Mặc quần áo", category: "Kappale 4: Verbit (Päivärytmi)" },
  { finnish: "Riisuutua", pronunciation: "/ˈrii.suu.tu.ɑ/", english: "To undress", vietnamese: "Cởi quần áo", category: "Kappale 4: Verbit (Päivärytmi)" },
  { finnish: "Laittaa ruokaa", pronunciation: "/ˈlɑit.tɑɑ ˈruo.kɑɑ/", english: "To cook food", vietnamese: "Nấu ăn", category: "Kappale 4: Verbit (Päivärytmi)" },
  { finnish: "Syödä", pronunciation: "/ˈsyø.dæ/", english: "To eat", vietnamese: "Ăn", category: "Kappale 4: Verbit" },
  { finnish: "Juoda", pronunciation: "/ˈjuo.dɑ/", english: "To drink", vietnamese: "Uống", category: "Kappale 4: Verbit" },
  { finnish: "Aamupala", pronunciation: "/ˈɑɑ.mu.pɑ.lɑ/", english: "Breakfast", vietnamese: "Bữa sáng", category: "Kappale 4: Ruoka-ajat" },
  { finnish: "Lounas", pronunciation: "/ˈlou.nɑs/", english: "Lunch", vietnamese: "Bữa trưa", category: "Kappale 4: Ruoka-ajat" },
  { finnish: "Päivällinen", pronunciation: "/ˈpæi.væl.li.nen/", english: "Dinner", vietnamese: "Bữa tối", category: "Kappale 4: Ruoka-ajat" },
  { finnish: "Iltapala", pronunciation: "/ˈil.tɑ.pɑ.lɑ/", english: "Evening snack", vietnamese: "Bữa ăn nhẹ buổi tối", category: "Kappale 4: Ruoka-ajat" },
  { finnish: "Mennä", pronunciation: "/ˈmen.næ/", english: "To go", vietnamese: "Đi", category: "Kappale 4: Verbit" },
  { finnish: "Tulla", pronunciation: "/ˈtul.lɑ/", english: "To come", vietnamese: "Đến", category: "Kappale 4: Verbit" },
  { finnish: "Opiskella", pronunciation: "/ˈo.pis.kel.lɑ/", english: "To study", vietnamese: "Học tập", category: "Kappale 4: Verbit" },
  { finnish: "Tehdä", pronunciation: "/ˈteh.dæ/", english: "To do / make", vietnamese: "Làm", category: "Kappale 4: Verbit" },
  { finnish: "Nukkua", pronunciation: "/ˈnuk.ku.ɑ/", english: "To sleep", vietnamese: "Ngủ", category: "Kappale 4: Verbit (Päivärytmi)" },
  { finnish: "Katsoa", pronunciation: "/ˈkɑt.so.ɑ/", english: "To watch / look", vietnamese: "Xem / Nhìn", category: "Kappale 4: Verbit" },
  { finnish: "Kuunnella", pronunciation: "/ˈkuun.nel.lɑ/", english: "To listen", vietnamese: "Nghe", category: "Kappale 4: Verbit" },
  { finnish: "Lukea", pronunciation: "/ˈlu.ke.ɑ/", english: "To read", vietnamese: "Đọc", category: "Kappale 4: Verbit" },
  { finnish: "Kirjoittaa", pronunciation: "/ˈkir.joit.tɑɑ/", english: "To write", vietnamese: "Viết", category: "Kappale 4: Verbit" },
  { finnish: "Siivota", pronunciation: "/ˈsii.vo.tɑ/", english: "To clean", vietnamese: "Dọn dẹp", category: "Kappale 4: Verbit (Päivärytmi)" },
  { finnish: "Tavata", pronunciation: "/ˈtɑ.vɑ.tɑ/", english: "To meet", vietnamese: "Gặp gỡ", category: "Kappale 4: Verbit" },
  { finnish: "Pelata", pronunciation: "/ˈpe.lɑ.tɑ/", english: "To play (games/sports)", vietnamese: "Chơi (game/thể thao)", category: "Kappale 4: Verbit" },
  { finnish: "Ymmärtää", pronunciation: "/ˈym.mær.tææ/", english: "To understand", vietnamese: "Hiểu", category: "Kappale 4: Yleiset Verbit" },
  { finnish: "Tietää", pronunciation: "/ˈtie.tææ/", english: "To know", vietnamese: "Biết", category: "Kappale 4: Yleiset Verbit" },
  { finnish: "Muistaa", pronunciation: "/ˈmuis.tɑɑ/", english: "To remember", vietnamese: "Nhớ", category: "Kappale 4: Yleiset Verbit" },
  { finnish: "Kysyä", pronunciation: "/ˈky.sy.æ/", english: "To ask", vietnamese: "Hỏi", category: "Kappale 4: Yleiset Verbit" },
  { finnish: "Vastata", pronunciation: "/ˈvɑs.tɑ.tɑ/", english: "To answer", vietnamese: "Trả lời", category: "Kappale 4: Yleiset Verbit" },
  { finnish: "Auttaa", pronunciation: "/ˈɑut.tɑɑ/", english: "To help", vietnamese: "Giúp đỡ", category: "Kappale 4: Yleiset Verbit" },
  { finnish: "Tarvita", pronunciation: "/ˈtɑr.vi.tɑ/", english: "To need", vietnamese: "Cần", category: "Kappale 4: Yleiset Verbit" },
  { finnish: "Haluta", pronunciation: "/ˈhɑ.lu.tɑ/", english: "To want", vietnamese: "Muốn", category: "Kappale 4: Yleiset Verbit" },
  { finnish: "Tykätä", pronunciation: "/ˈty.kæ.tæ/", english: "To like", vietnamese: "Thích", category: "Kappale 4: Yleiset Verbit" },
  { finnish: "Vihata", pronunciation: "/ˈvi.hɑ.tɑ/", english: "To hate", vietnamese: "Ghét", category: "Kappale 4: Yleiset Verbit" },
  { finnish: "Nauraa", pronunciation: "/ˈnɑu.rɑɑ/", english: "To laugh", vietnamese: "Cười", category: "Kappale 4: Yleiset Verbit" },
  { finnish: "Itkeä", pronunciation: "/ˈit.ke.æ/", english: "To cry", vietnamese: "Khóc", category: "Kappale 4: Yleiset Verbit" },
  { finnish: "Hymyillä", pronunciation: "/ˈhy.myil.læ/", english: "To smile", vietnamese: "Mỉm cười", category: "Kappale 4: Yleiset Verbit" },

  // --- KAPPALE 5: Ruoka, Astiat & Ostokset ---
  { finnish: "Ruoka", pronunciation: "/ˈruo.kɑ/", english: "Food", vietnamese: "Thức ăn", category: "Kappale 5: Ruoka" },
  { finnish: "Juoma", pronunciation: "/ˈjuo.mɑ/", english: "Drink", vietnamese: "Đồ uống", category: "Kappale 5: Juoma" },
  { finnish: "Vesi", pronunciation: "/ˈve.si/", english: "Water", vietnamese: "Nước", category: "Kappale 5: Juoma" },
  { finnish: "Maito", pronunciation: "/ˈmɑi.to/", english: "Milk", vietnamese: "Sữa", category: "Kappale 5: Juoma" },
  { finnish: "Mehu", pronunciation: "/ˈme.hu/", english: "Juice", vietnamese: "Nước ép", category: "Kappale 5: Juoma" },
  { finnish: "Kahvi", pronunciation: "/ˈkɑh.vi/", english: "Coffee", vietnamese: "Cà phê", category: "Kappale 5: Juoma" },
  { finnish: "Tee", pronunciation: "/tee/", english: "Tea", vietnamese: "Trà", category: "Kappale 5: Juoma" },
  { finnish: "Olut", pronunciation: "/ˈo.lut/", english: "Beer", vietnamese: "Bia", category: "Kappale 5: Juoma" },
  { finnish: "Viini", pronunciation: "/ˈvii.ni/", english: "Wine", vietnamese: "Rượu vang", category: "Kappale 5: Juoma" },
  { finnish: "Leipä", pronunciation: "/ˈlei.pæ/", english: "Bread", vietnamese: "Bánh mì", category: "Kappale 5: Ruoka" },
  { finnish: "Voi", pronunciation: "/voi/", english: "Butter", vietnamese: "Bơ", category: "Kappale 5: Ruoka" },
  { finnish: "Juusto", pronunciation: "/ˈjuus.to/", english: "Cheese", vietnamese: "Phô mai", category: "Kappale 5: Ruoka" },
  { finnish: "Jogurtti", pronunciation: "/ˈjo.gurt.ti/", english: "Yogurt", vietnamese: "Sữa chua", category: "Kappale 5: Ruoka" },
  { finnish: "Kerma", pronunciation: "/ˈker.mɑ/", english: "Cream", vietnamese: "Kem (sữa)", category: "Kappale 5: Ruoka" },
  { finnish: "Kinkku", pronunciation: "/ˈkiŋk.ku/", english: "Ham", vietnamese: "Thịt giăm bông", category: "Kappale 5: Ruoka" },
  { finnish: "Makkara", pronunciation: "/ˈmɑk.kɑ.rɑ/", english: "Sausage", vietnamese: "Xúc xích", category: "Kappale 5: Ruoka" },
  { finnish: "Liha", pronunciation: "/ˈli.hɑ/", english: "Meat", vietnamese: "Thịt", category: "Kappale 5: Ruoka" },
  { finnish: "Naudanliha", pronunciation: "/ˈnɑu.dɑn.li.hɑ/", english: "Beef", vietnamese: "Thịt bò", category: "Kappale 5: Ruoka" },
  { finnish: "Porsaanliha", pronunciation: "/ˈpor.sɑɑn.li.hɑ/", english: "Pork", vietnamese: "Thịt lợn", category: "Kappale 5: Ruoka" },
  { finnish: "Kana", pronunciation: "/ˈkɑ.nɑ/", english: "Chicken", vietnamese: "Thịt gà", category: "Kappale 5: Ruoka" },
  { finnish: "Kala", pronunciation: "/ˈkɑ.lɑ/", english: "Fish", vietnamese: "Cá", category: "Kappale 5: Ruoka" },
  { finnish: "Kananmuna", pronunciation: "/ˈkɑ.nɑn.mu.nɑ/", english: "Egg", vietnamese: "Trứng", category: "Kappale 5: Ruoka" },
  { finnish: "Riisi", pronunciation: "/ˈrii.si/", english: "Rice", vietnamese: "Gạo / Cơm", category: "Kappale 5: Ruoka" },
  { finnish: "Pasta", pronunciation: "/ˈpɑs.tɑ/", english: "Pasta", vietnamese: "Mỳ Ý", category: "Kappale 5: Ruoka" },
  { finnish: "Puuro", pronunciation: "/ˈpuu.ro/", english: "Porridge", vietnamese: "Cháo", category: "Kappale 5: Ruoka" },
  { finnish: "Keitto", pronunciation: "/ˈkeit.to/", english: "Soup", vietnamese: "Súp / Canh", category: "Kappale 5: Ruoka" },
  { finnish: "Kastike", pronunciation: "/ˈkɑs.ti.ke/", english: "Sauce", vietnamese: "Nước xốt", category: "Kappale 5: Ruoka" },
  { finnish: "Peruna", pronunciation: "/ˈpe.ru.nɑ/", english: "Potato", vietnamese: "Khoai tây", category: "Kappale 5: Vihannekset" },
  { finnish: "Porkkana", pronunciation: "/ˈpork.kɑ.nɑ/", english: "Carrot", vietnamese: "Cà rốt", category: "Kappale 5: Vihannekset" },
  { finnish: "Sipuli", pronunciation: "/ˈsi.pu.li/", english: "Onion", vietnamese: "Hành tây", category: "Kappale 5: Vihannekset" },
  { finnish: "Valkosipuli", pronunciation: "/ˈvɑl.ko.si.pu.li/", english: "Garlic", vietnamese: "Tỏi", category: "Kappale 5: Vihannekset" },
  { finnish: "Tomaatti", pronunciation: "/ˈto.mɑɑt.ti/", english: "Tomato", vietnamese: "Cà chua", category: "Kappale 5: Vihannekset" },
  { finnish: "Kurkku", pronunciation: "/ˈkurk.ku/", english: "Cucumber", vietnamese: "Dưa chuột", category: "Kappale 5: Vihannekset" },
  { finnish: "Salaatti", pronunciation: "/ˈsɑ.lɑɑt.ti/", english: "Salad / Lettuce", vietnamese: "Xà lách", category: "Kappale 5: Vihannekset" },
  { finnish: "Sieni", pronunciation: "/ˈsie.ni/", english: "Mushroom", vietnamese: "Nấm", category: "Kappale 5: Vihannekset" },
  { finnish: "Omena", pronunciation: "/ˈo.me.nɑ/", english: "Apple", vietnamese: "Quả táo", category: "Kappale 5: Hedelmät" },
  { finnish: "Banaani", pronunciation: "/ˈbɑ.nɑɑ.ni/", english: "Banana", vietnamese: "Quả chuối", category: "Kappale 5: Hedelmät" },
  { finnish: "Appelsiini", pronunciation: "/ˈɑp.pel.sii.ni/", english: "Orange", vietnamese: "Quả cam", category: "Kappale 5: Hedelmät" },
  { finnish: "Sitruuna", pronunciation: "/ˈsit.ruu.nɑ/", english: "Lemon", vietnamese: "Quả chanh", category: "Kappale 5: Hedelmät" },
  { finnish: "Marja", pronunciation: "/ˈmɑr.jɑ/", english: "Berry", vietnamese: "Quả mọng", category: "Kappale 5: Hedelmät" },
  { finnish: "Mansikka", pronunciation: "/ˈmɑn.sik.kɑ/", english: "Strawberry", vietnamese: "Dâu tây", category: "Kappale 5: Hedelmät" },
  { finnish: "Suola", pronunciation: "/ˈsuo.lɑ/", english: "Salt", vietnamese: "Muối", category: "Kappale 5: Mausteet" },
  { finnish: "Pippuri", pronunciation: "/ˈpip.pu.ri/", english: "Pepper", vietnamese: "Hạt tiêu", category: "Kappale 5: Mausteet" },
  { finnish: "Sokeri", pronunciation: "/ˈso.ke.ri/", english: "Sugar", vietnamese: "Đường", category: "Kappale 5: Mausteet" },
  { finnish: "Viinietikka", pronunciation: "/ˈvii.ni.e.tik.kɑ/", english: "Vinegar", vietnamese: "Giấm", category: "Kappale 5: Mausteet" },
  { finnish: "Öljy", pronunciation: "/ˈøl.jy/", english: "Oil", vietnamese: "Dầu ăn", category: "Kappale 5: Mausteet" },
  { finnish: "Jäätelö", pronunciation: "/ˈjææ.te.lø/", english: "Ice cream", vietnamese: "Kem", category: "Kappale 5: Herkut" },
  { finnish: "Suklaa", pronunciation: "/ˈsuk.lɑɑ/", english: "Chocolate", vietnamese: "Sô-cô-la", category: "Kappale 5: Herkut" },
  { finnish: "Kakku", pronunciation: "/ˈkɑk.ku/", english: "Cake", vietnamese: "Bánh kem", category: "Kappale 5: Herkut" },
  { finnish: "Karkki", pronunciation: "/ˈkɑrk.ki/", english: "Candy", vietnamese: "Kẹo", category: "Kappale 5: Herkut" },
  { finnish: "Lautanen", pronunciation: "/ˈlɑu.tɑ.nen/", english: "Plate", vietnamese: "Cái đĩa", category: "Kappale 5: Astiat" },
  { finnish: "Lasi", pronunciation: "/ˈlɑ.si/", english: "Glass", vietnamese: "Cái ly", category: "Kappale 5: Astiat" },
  { finnish: "Muki", pronunciation: "/ˈmu.ki/", english: "Mug", vietnamese: "Cái cốc", category: "Kappale 5: Astiat" },
  { finnish: "Kuppi", pronunciation: "/ˈkup.pi/", english: "Cup", vietnamese: "Tách", category: "Kappale 5: Astiat" },
  { finnish: "Veitsi", pronunciation: "/ˈveit.si/", english: "Knife", vietnamese: "Con dao", category: "Kappale 5: Astiat" },
  { finnish: "Haarukka", pronunciation: "/ˈhɑɑ.ruk.kɑ/", english: "Fork", vietnamese: "Cái dĩa (nĩa)", category: "Kappale 5: Astiat" },
  { finnish: "Lusikka", pronunciation: "/ˈlu.sik.kɑ/", english: "Spoon", vietnamese: "Cái thìa", category: "Kappale 5: Astiat" },
  { finnish: "Kattila", pronunciation: "/ˈkɑt.ti.lɑ/", english: "Pot", vietnamese: "Cái nồi", category: "Kappale 5: Astiat" },
  { finnish: "Pannu", pronunciation: "/ˈpɑn.nu/", english: "Pan", vietnamese: "Cái chảo", category: "Kappale 5: Astiat" },
  { finnish: "Pullo", pronunciation: "/ˈpul.lo/", english: "Bottle", vietnamese: "Cái chai", category: "Kappale 5: Astiat" },
  { finnish: "Ostaa", pronunciation: "/ˈos.tɑɑ/", english: "To buy", vietnamese: "Mua", category: "Kappale 5: Verbit" },
  { finnish: "Maksaa", pronunciation: "/ˈmɑk.sɑɑ/", english: "To pay / cost", vietnamese: "Trả tiền / Giá là", category: "Kappale 5: Verbit" },
  { finnish: "Rakastaa", pronunciation: "/ˈrɑ.kɑs.tɑɑ/", english: "To love", vietnamese: "Yêu thích", category: "Kappale 5: Verbit" },

  // --- KAPPALE 6: Paikat, Kaupunki, Liikenne & Suunnat ---
  { finnish: "Kaupunki", pronunciation: "/ˈkɑu.puŋ.ki/", english: "City", vietnamese: "Thành phố", category: "Kappale 6: Paikat" },
  { finnish: "Kylä", pronunciation: "/ˈky.læ/", english: "Village", vietnamese: "Ngôi làng", category: "Kappale 6: Paikat" },
  { finnish: "Paikka", pronunciation: "/ˈpɑik.kɑ/", english: "Place", vietnamese: "Địa điểm", category: "Kappale 6: Paikat" },
  { finnish: "Katu", pronunciation: "/ˈkɑ.tu/", english: "Street", vietnamese: "Đường phố", category: "Kappale 6: Paikat" },
  { finnish: "Tie", pronunciation: "/tie/", english: "Road", vietnamese: "Con đường", category: "Kappale 6: Paikat" },
  { finnish: "Polku", pronunciation: "/ˈpol.ku/", english: "Path", vietnamese: "Lối mòn", category: "Kappale 6: Paikat" },
  { finnish: "Silta", pronunciation: "/ˈsil.tɑ/", english: "Bridge", vietnamese: "Cây cầu", category: "Kappale 6: Paikat" },
  { finnish: "Risteys", pronunciation: "/ˈris.teus/", english: "Intersection", vietnamese: "Ngã tư", category: "Kappale 6: Paikat" },
  { finnish: "Liikennevalo", pronunciation: "/ˈlii.ken.ne.vɑ.lo/", english: "Traffic light", vietnamese: "Đèn giao thông", category: "Kappale 6: Paikat" },
  { finnish: "Tori", pronunciation: "/ˈto.ri/", english: "Market square", vietnamese: "Quảng trường chợ", category: "Kappale 6: Paikat" },
  { finnish: "Puisto", pronunciation: "/ˈpuis.to/", english: "Park", vietnamese: "Công viên", category: "Kappale 6: Paikat" },
  { finnish: "Koulu", pronunciation: "/ˈkou.lu/", english: "School", vietnamese: "Trường học", category: "Kappale 6: Paikat" },
  { finnish: "Päiväkoti", pronunciation: "/ˈpæi.væ.ko.ti/", english: "Kindergarten", vietnamese: "Nhà trẻ", category: "Kappale 6: Paikat" },
  { finnish: "Kirjasto", pronunciation: "/ˈkir.jɑs.to/", english: "Library", vietnamese: "Thư viện", category: "Kappale 6: Paikat" },
  { finnish: "Elokuvateatteri", pronunciation: "/ˈe.lo.ku.vɑ.te.ɑt.te.ri/", english: "Cinema", vietnamese: "Rạp chiếu phim", category: "Kappale 6: Paikat" },
  { finnish: "Uimahalli", pronunciation: "/ˈui.mɑ.hɑl.li/", english: "Swimming hall", vietnamese: "Bể bơi trong nhà", category: "Kappale 6: Paikat" },
  { finnish: "Kuntosali", pronunciation: "/ˈkun.to.sɑ.li/", english: "Gym", vietnamese: "Phòng gym", category: "Kappale 6: Paikat" },
  { finnish: "Koti", pronunciation: "/ˈko.ti/", english: "Home", vietnamese: "Ngôi nhà", category: "Kappale 6: Paikat" },
  { finnish: "Työ", pronunciation: "/tyø/", english: "Work", vietnamese: "Nơi làm việc", category: "Kappale 6: Paikat" },
  { finnish: "Kauppa", pronunciation: "/ˈkɑup.pɑ/", english: "Shop / Store", vietnamese: "Cửa hàng", category: "Kappale 6: Paikat" },
  { finnish: "Kioski", pronunciation: "/ˈki.os.ki/", english: "Kiosk", vietnamese: "Quầy tạp hóa nhỏ", category: "Kappale 6: Paikat" },
  { finnish: "Pankki", pronunciation: "/ˈpɑŋk.ki/", english: "Bank", vietnamese: "Ngân hàng", category: "Kappale 6: Paikat" },
  { finnish: "Posti", pronunciation: "/ˈpos.ti/", english: "Post office", vietnamese: "Bưu điện", category: "Kappale 6: Paikat" },
  { finnish: "Apteekki", pronunciation: "/ˈɑp.teek.ki/", english: "Pharmacy", vietnamese: "Hiệu thuốc", category: "Kappale 6: Paikat" },
  { finnish: "Sairaala", pronunciation: "/ˈsɑi.rɑɑ.lɑ/", english: "Hospital", vietnamese: "Bệnh viện", category: "Kappale 6: Paikat" },
  { finnish: "Kirkko", pronunciation: "/ˈkirk.ko/", english: "Church", vietnamese: "Nhà thờ", category: "Kappale 6: Paikat" },
  { finnish: "Asema", pronunciation: "/ˈɑ.se.mɑ/", english: "Station", vietnamese: "Nhà ga", category: "Kappale 6: Liikenne" },
  { finnish: "Lentokenttä", pronunciation: "/ˈlen.to.kent.tæ/", english: "Airport", vietnamese: "Sân bay", category: "Kappale 6: Liikenne" },
  { finnish: "Satama", pronunciation: "/ˈsɑ.tɑ.mɑ/", english: "Harbor / Port", vietnamese: "Bến cảng", category: "Kappale 6: Liikenne" },
  { finnish: "Hotelli", pronunciation: "/ˈho.tel.li/", english: "Hotel", vietnamese: "Khách sạn", category: "Kappale 6: Paikat" },
  { finnish: "Ravintola", pronunciation: "/ˈrɑ.vin.to.lɑ/", english: "Restaurant", vietnamese: "Nhà hàng", category: "Kappale 6: Paikat" },
  { finnish: "Kahvila", pronunciation: "/ˈkɑh.vi.lɑ/", english: "Cafe", vietnamese: "Quán cà phê", category: "Kappale 6: Paikat" },
  { finnish: "Baari", pronunciation: "/ˈbɑɑ.ri/", english: "Bar", vietnamese: "Quán bar", category: "Kappale 6: Paikat" },
  { finnish: "Bussi", pronunciation: "/ˈbus.si/", english: "Bus", vietnamese: "Xe buýt", category: "Kappale 6: Liikenne" },
  { finnish: "Juna", pronunciation: "/ˈju.nɑ/", english: "Train", vietnamese: "Tàu hỏa", category: "Kappale 6: Liikenne" },
  { finnish: "Raitiovaunu", pronunciation: "/ˈrɑi.ti.o.vɑu.nu/", english: "Tram", vietnamese: "Tàu điện mặt đất", category: "Kappale 6: Liikenne" },
  { finnish: "Metro", pronunciation: "/ˈmet.ro/", english: "Subway / Metro", vietnamese: "Tàu điện ngầm", category: "Kappale 6: Liikenne" },
  { finnish: "Laiva", pronunciation: "/ˈlɑi.vɑ/", english: "Ship / Boat", vietnamese: "Tàu thủy", category: "Kappale 6: Liikenne" },
  { finnish: "Lentokone", pronunciation: "/ˈlen.to.ko.ne/", english: "Airplane", vietnamese: "Máy bay", category: "Kappale 6: Liikenne" },
  { finnish: "Auto", pronunciation: "/ˈɑu.to/", english: "Car", vietnamese: "Ô tô", category: "Kappale 6: Liikenne" },
  { finnish: "Pyörä", pronunciation: "/ˈpyø.ræ/", english: "Bicycle", vietnamese: "Xe đạp", category: "Kappale 6: Liikenne" },
  { finnish: "Oikea", pronunciation: "/ˈoi.ke.ɑ/", english: "Right", vietnamese: "Bên phải", category: "Kappale 6: Suunnat" },
  { finnish: "Vasen", pronunciation: "/ˈvɑ.sen/", english: "Left", vietnamese: "Bên trái", category: "Kappale 6: Suunnat" },
  { finnish: "Suoraan", pronunciation: "/ˈsuo.rɑɑn/", english: "Straight", vietnamese: "Đi thẳng", category: "Kappale 6: Suunnat" },
  { finnish: "Eteenpäin", pronunciation: "/ˈe.teen.pæin/", english: "Forward", vietnamese: "Tiến về phía trước", category: "Kappale 6: Suunnat" },
  { finnish: "Taaksepäin", pronunciation: "/ˈtɑɑk.se.pæin/", english: "Backward", vietnamese: "Lùi về phía sau", category: "Kappale 6: Suunnat" },

  // --- KAPPALE 7: Perhe, Laajat Ruumiinosat & Ulkonäkö ---
  { finnish: "Perhe", pronunciation: "/ˈper.he/", english: "Family", vietnamese: "Gia đình", category: "Kappale 7: Perhe" },
  { finnish: "Sukulainen", pronunciation: "/ˈsu.ku.lɑi.nen/", english: "Relative", vietnamese: "Họ hàng", category: "Kappale 7: Perhe" },
  { finnish: "Vanhemmat", pronunciation: "/ˈvɑn.hem.mɑt/", english: "Parents", vietnamese: "Bố mẹ", category: "Kappale 7: Perhe" },
  { finnish: "Äiti", pronunciation: "/ˈæi.ti/", english: "Mother", vietnamese: "Mẹ", category: "Kappale 7: Perhe" },
  { finnish: "Isä", pronunciation: "/ˈi.sæ/", english: "Father", vietnamese: "Bố", category: "Kappale 7: Perhe" },
  { finnish: "Lapsi", pronunciation: "/ˈlɑp.si/", english: "Child", vietnamese: "Đứa trẻ", category: "Kappale 7: Perhe" },
  { finnish: "Poika", pronunciation: "/ˈpoi.kɑ/", english: "Son / Boy", vietnamese: "Con trai", category: "Kappale 7: Perhe" },
  { finnish: "Tytär", pronunciation: "/ˈty.tær/", english: "Daughter", vietnamese: "Con gái", category: "Kappale 7: Perhe" },
  { finnish: "Tyttö", pronunciation: "/ˈtyt.tø/", english: "Girl", vietnamese: "Bé gái", category: "Kappale 7: Perhe" },
  { finnish: "Sisko", pronunciation: "/ˈsis.ko/", english: "Sister", vietnamese: "Chị/Em gái", category: "Kappale 7: Perhe" },
  { finnish: "Veli", pronunciation: "/ˈve.li/", english: "Brother", vietnamese: "Anh/Em trai", category: "Kappale 7: Perhe" },
  { finnish: "Isoäiti", pronunciation: "/ˈi.so.æi.ti/", english: "Grandmother", vietnamese: "Bà", category: "Kappale 7: Perhe" },
  { finnish: "Isoisä", pronunciation: "/ˈi.so.i.sæ/", english: "Grandfather", vietnamese: "Ông", category: "Kappale 7: Perhe" },
  { finnish: "Setä", pronunciation: "/ˈse.tæ/", english: "Uncle (paternal)", vietnamese: "Chú / Bác trai", category: "Kappale 7: Perhe" },
  { finnish: "Täti", pronunciation: "/ˈtæ.ti/", english: "Aunt", vietnamese: "Cô / Dì", category: "Kappale 7: Perhe" },
  { finnish: "Serkku", pronunciation: "/ˈserk.ku/", english: "Cousin", vietnamese: "Anh chị em họ", category: "Kappale 7: Perhe" },
  { finnish: "Anoppi", pronunciation: "/ˈɑ.nop.pi/", english: "Mother-in-law", vietnamese: "Mẹ vợ / Mẹ chồng", category: "Kappale 7: Perhe" },
  { finnish: "Appi", pronunciation: "/ˈɑp.pi/", english: "Father-in-law", vietnamese: "Bố vợ / Bố chồng", category: "Kappale 7: Perhe" },
  { finnish: "Mies", pronunciation: "/mies/", english: "Man / Husband", vietnamese: "Đàn ông / Chồng", category: "Kappale 7: Ihmissuhteet" },
  { finnish: "Nainen", pronunciation: "/ˈnɑi.nen/", english: "Woman", vietnamese: "Phụ nữ", category: "Kappale 7: Ihmissuhteet" },
  { finnish: "Vaimo", pronunciation: "/ˈvɑi.mo/", english: "Wife", vietnamese: "Vợ", category: "Kappale 7: Ihmissuhteet" },
  { finnish: "Poikaystävä", pronunciation: "/ˈpoi.kɑ.ys.tæ.væ/", english: "Boyfriend", vietnamese: "Bạn trai", category: "Kappale 7: Ihmissuhteet" },
  { finnish: "Tyttöystävä", pronunciation: "/ˈtyt.tø.ys.tæ.væ/", english: "Girlfriend", vietnamese: "Bạn gái", category: "Kappale 7: Ihmissuhteet" },
  { finnish: "Ystävä", pronunciation: "/ˈys.tæ.væ/", english: "Friend", vietnamese: "Bạn bè", category: "Kappale 7: Ihmissuhteet" },
  { finnish: "Pää", pronunciation: "/pææ/", english: "Head", vietnamese: "Cái đầu", category: "Kappale 7: Ruumiinosat" },
  { finnish: "Hiukset", pronunciation: "/ˈhiuk.set/", english: "Hair", vietnamese: "Mái tóc", category: "Kappale 7: Ruumiinosat" },
  { finnish: "Kasvot", pronunciation: "/ˈkɑs.vot/", english: "Face", vietnamese: "Khuôn mặt", category: "Kappale 7: Ruumiinosat" },
  { finnish: "Otsa", pronunciation: "/ˈot.sɑ/", english: "Forehead", vietnamese: "Trán", category: "Kappale 7: Ruumiinosat" },
  { finnish: "Poski", pronunciation: "/ˈpos.ki/", english: "Cheek", vietnamese: "Má", category: "Kappale 7: Ruumiinosat" },
  { finnish: "Leuka", pronunciation: "/ˈleu.kɑ/", english: "Chin / Jaw", vietnamese: "Cằm", category: "Kappale 7: Ruumiinosat" },
  { finnish: "Niska", pronunciation: "/ˈnis.kɑ/", english: "Back of the neck", vietnamese: "Gáy", category: "Kappale 7: Ruumiinosat" },
  { finnish: "Kaula", pronunciation: "/ˈkɑu.lɑ/", english: "Neck", vietnamese: "Cổ", category: "Kappale 7: Ruumiinosat" },
  { finnish: "Silmä", pronunciation: "/ˈsil.mæ/", english: "Eye", vietnamese: "Mắt", category: "Kappale 7: Ruumiinosat" },
  { finnish: "Korva", pronunciation: "/ˈkor.vɑ/", english: "Ear", vietnamese: "Tai", category: "Kappale 7: Ruumiinosat" },
  { finnish: "Nenä", pronunciation: "/ˈne.næ/", english: "Nose", vietnamese: "Mũi", category: "Kappale 7: Ruumiinosat" },
  { finnish: "Suu", pronunciation: "/suu/", english: "Mouth", vietnamese: "Miệng", category: "Kappale 7: Ruumiinosat" },
  { finnish: "Hammas", pronunciation: "/ˈhɑm.mɑs/", english: "Tooth", vietnamese: "Răng", category: "Kappale 7: Ruumiinosat" },
  { finnish: "Hartia", pronunciation: "/ˈhɑr.ti.ɑ/", english: "Shoulder", vietnamese: "Vai", category: "Kappale 7: Ruumiinosat" },
  { finnish: "Rinta", pronunciation: "/ˈrin.tɑ/", english: "Chest", vietnamese: "Ngực", category: "Kappale 7: Ruumiinosat" },
  { finnish: "Käsi", pronunciation: "/ˈkæ.si/", english: "Hand / Arm", vietnamese: "Tay", category: "Kappale 7: Ruumiinosat" },
  { finnish: "Käsivarsi", pronunciation: "/ˈkæ.si.vɑr.si/", english: "Arm", vietnamese: "Cánh tay", category: "Kappale 7: Ruumiinosat" },
  { finnish: "Kyynärpää", pronunciation: "/ˈkyy.nær.pææ/", english: "Elbow", vietnamese: "Khuỷu tay", category: "Kappale 7: Ruumiinosat" },
  { finnish: "Sormi", pronunciation: "/ˈsor.mi/", english: "Finger", vietnamese: "Ngón tay", category: "Kappale 7: Ruumiinosat" },
  { finnish: "Jalka", pronunciation: "/ˈjɑl.kɑ/", english: "Leg / Foot", vietnamese: "Chân", category: "Kappale 7: Ruumiinosat" },
  { finnish: "Polvi", pronunciation: "/ˈpol.vi/", english: "Knee", vietnamese: "Đầu gối", category: "Kappale 7: Ruumiinosat" },
  { finnish: "Nilkka", pronunciation: "/ˈnilk.kɑ/", english: "Ankle", vietnamese: "Mắt cá chân", category: "Kappale 7: Ruumiinosat" },
  { finnish: "Varvas", pronunciation: "/ˈvɑr.vɑs/", english: "Toe", vietnamese: "Ngón chân", category: "Kappale 7: Ruumiinosat" },
  { finnish: "Vatsa", pronunciation: "/ˈvɑt.sɑ/", english: "Stomach", vietnamese: "Bụng", category: "Kappale 7: Ruumiinosat" },
  { finnish: "Selkä", pronunciation: "/ˈsel.kæ/", english: "Back", vietnamese: "Lưng", category: "Kappale 7: Ruumiinosat" },
  { finnish: "Kiharat hiukset", pronunciation: "/ˈki.hɑ.rɑt ˈhiuk.set/", english: "Curly hair", vietnamese: "Tóc xoăn", category: "Kappale 7: Ulkonäkö" },
  { finnish: "Suorat hiukset", pronunciation: "/ˈsuo.rɑt ˈhiuk.set/", english: "Straight hair", vietnamese: "Tóc thẳng", category: "Kappale 7: Ulkonäkö" },
  { finnish: "Silmälasit", pronunciation: "/ˈsil.mæ.lɑ.sit/", english: "Glasses", vietnamese: "Kính mắt", category: "Kappale 7: Ulkonäkö" }
];

// DỮ LIỆU NGỮ PHÁP (Từ Kappale 1 - 9)
const grammarList = [
  {
    id: 'olla', chapter: 'Kappale 1', title: 'Động từ "Olla" (To be)', desc: 'Dùng để giới thiệu bản thân, quốc tịch, tuổi tác...',
    content: (
      <table className="w-full text-left border-collapse bg-white rounded-lg shadow-sm border border-slate-200 overflow-hidden text-sm">
        <thead><tr className="bg-slate-50 border-b border-slate-200"><th className="py-3 px-4 font-semibold">Đại từ</th><th className="py-3 px-4 font-bold text-blue-600">Olla</th></tr></thead>
        <tbody className="divide-y divide-slate-100">
          <tr><td className="py-2 px-4">Minä (Tôi)</td><td className="py-2 px-4 font-bold text-blue-600">olen</td></tr>
          <tr><td className="py-2 px-4">Sinä (Bạn)</td><td className="py-2 px-4 font-bold text-blue-600">olet</td></tr>
          <tr><td className="py-2 px-4">Hän (Anh/Cô ấy)</td><td className="py-2 px-4 font-bold text-blue-600">on</td></tr>
          <tr><td className="py-2 px-4">Me (Chúng tôi)</td><td className="py-2 px-4 font-bold text-blue-600">olemme</td></tr>
          <tr><td className="py-2 px-4">Te (Các bạn)</td><td className="py-2 px-4 font-bold text-blue-600">olette</td></tr>
          <tr><td className="py-2 px-4">He (Họ)</td><td className="py-2 px-4 font-bold text-blue-600">ovat</td></tr>
        </tbody>
      </table>
    )
  },
  {
    id: 'vokaaliharmonia', chapter: 'Kappale 1', title: 'Vokaaliharmonia (Hài hòa nguyên âm)', desc: 'Quy tắc kết hợp nguyên âm trong một từ đơn.',
    content: (
      <div className="flex gap-4 text-center mt-2">
        <div className="flex-1 bg-rose-50 p-2 rounded border border-rose-200"><div className="font-semibold text-rose-600 text-xs mb-1">Nhóm sau</div><div className="font-bold">A O U</div></div>
        <div className="flex-1 bg-emerald-50 p-2 rounded border border-emerald-200"><div className="font-semibold text-emerald-600 text-xs mb-1">Nhóm trước</div><div className="font-bold">Ä Ö Y</div></div>
        <div className="flex-1 bg-slate-50 p-2 rounded border border-slate-200"><div className="font-semibold text-slate-500 text-xs mb-1">Trung lập</div><div className="font-bold">E I</div></div>
      </div>
    )
  },
  {
    id: 'verb1', chapter: 'Kappale 3', title: 'Verbityyppi 1 (Động từ nhóm 1)', desc: 'Bỏ chữ "a" hoặc "ä" cuối cùng để lấy gốc (vartalo), sau đó cộng đuôi nhân xưng.',
    content: (
      <div className="bg-white p-3 rounded-lg border border-slate-200 text-sm mt-2">
        <p className="font-semibold mb-2 text-blue-700">Ví dụ: Puhua (Nói) {'->'} Gốc: Puhu-</p>
        <ul className="grid grid-cols-2 gap-2">
          <li>Minä puhu<b>n</b></li><li>Me puhu<b>mme</b></li>
          <li>Sinä puhu<b>t</b></li><li>Te puhu<b>tte</b></li>
          <li>Hän puhu<b>u</b> <i>(nhân đôi)</i></li><li>He puhu<b>vat</b></li>
        </ul>
      </div>
    )
  },
  {
    id: 'kpt', chapter: 'Kappale 3', title: 'K-P-T Vaihtelu (Biến đổi phụ âm K-P-T)', desc: 'Phụ âm K, P, T bị biến đổi từ Mạnh sang Yếu khi thêm đuôi.',
    content: (
      <div className="bg-white p-3 rounded-lg border border-slate-200 text-sm mt-2 space-y-2">
        <p><b>Quy tắc cơ bản (Mạnh {'->'} Yếu):</b></p>
        <ul className="grid grid-cols-2 gap-x-4 gap-y-1 ml-4 list-disc text-slate-700">
          <li>kk {'->'} k (Kuk<b>k</b>a {'->'} Ku<b>k</b>an)</li><li>pp {'->'} p (Kup<b>p</b>i {'->'} Ku<b>p</b>in)</li>
          <li>tt {'->'} t (Tyt<b>t</b>ö {'->'} Ty<b>t</b>ön)</li><li>k {'->'} - (Rei<b>k</b>ä {'->'} Reiän)</li>
          <li>p {'->'} v (Leipä {'->'} Leivän)</li><li>t {'->'} d (Pöytä {'->'} Pöydän)</li>
        </ul>
      </div>
    )
  },
  {
    id: 'koko', chapter: 'Kappale 3', title: 'Kysymys -ko/-kö (Câu hỏi Yes/No)', desc: 'Thêm đuôi -ko hoặc -kö vào từ muốn hỏi.',
    content: (
      <div className="bg-white p-3 rounded-lg border border-slate-200 text-sm mt-2">
        <p>Puhut<b>ko</b> sinä suomea? (Bạn có nói tiếng Phần không?)</p>
        <p>On<b>ko</b> hän suomalainen? (Anh ấy có phải người Phần không?)</p>
      </div>
    )
  },
  {
    id: 'verb2_5', chapter: 'Kappale 4', title: 'Verbityyppi 2-5 (Động từ nhóm 2, 3, 4, 5)', desc: 'Cách chia các nhóm động từ còn lại.',
    content: (
      <div className="bg-white p-3 rounded-lg border border-slate-200 text-sm mt-2 space-y-3">
        <div><span className="font-semibold text-blue-700">Nhóm 2:</span> Juo<b>da</b> {'->'} Minä juo<b>n</b>.</div>
        <div><span className="font-semibold text-blue-700">Nhóm 3:</span> Opiskel<b>la</b> {'->'} Minä opiskele<b>n</b>.</div>
        <div><span className="font-semibold text-blue-700">Nhóm 4:</span> Tava<b>ta</b> {'->'} Minä tapaa<b>n</b>.</div>
        <div><span className="font-semibold text-blue-700">Nhóm 5:</span> Tarv<b>ita</b> {'->'} Minä tarvitse<b>n</b>.</div>
      </div>
    )
  },
  {
    id: 'partitiivi', chapter: 'Kappale 5', title: 'Partitiivi (Cách phần vị - Số ít)', desc: 'Dùng sau số đếm, đồ ăn/thức uống, hoặc hành động chưa hoàn thành.',
    content: (
      <ul className="list-disc pl-5 space-y-1 text-sm bg-white p-3 border rounded-lg mt-2">
        <li>Đuôi <b>-a / -ä</b>: 1 nguyên âm ngắn (kahvi {'->'} kahvi<b>a</b>).</li>
        <li>Đuôi <b>-ta / -tä</b>: 2 nguyên âm hoặc phụ âm (tee {'->'} tee<b>tä</b>).</li>
      </ul>
    )
  },
  {
    id: 'paikallissijat', chapter: 'Kappale 6', title: 'Paikallissijat (Ngữ pháp phương hướng)', desc: 'Dùng để diễn tả vị trí: Ở đâu, Từ đâu, Đến đâu.',
    content: (
      <div className="bg-white p-3 rounded-lg border border-slate-200 text-sm mt-2 space-y-2">
        <p>📍 <b>Missä:</b> <b>-ssa / -ssä</b> (talo<b>ssa</b>) hoặc <b>-lla / -llä</b> (tori<b>lla</b>).</p>
        <p>⬅️ <b>Mistä:</b> <b>-sta / -stä</b> hoặc <b>-lta / -ltä</b>.</p>
        <p>➡️ <b>Mihin:</b> Nhân đôi nguyên âm cuối + <b>n</b> (koulu<b>un</b>) hoặc <b>-lle</b>.</p>
      </div>
    )
  },
  {
    id: 'omistuslause', chapter: 'Kappale 7', title: 'Omistuslause (Cấu trúc "Tôi có...")', desc: 'Không có động từ "have". Cấu trúc: [Người ở dạng -lla/-llä] + on + [Vật].',
    content: (
      <div className="bg-white p-3 rounded-lg border border-slate-200 text-sm mt-2">
        <p className="font-medium">Vd: Minu<b>lla</b> on koira. (Tôi có chó.)</p>
      </div>
    )
  },
  {
    id: 'monikko', chapter: 'Kappale 8', title: 'Monikon nominatiivi (Số nhiều)', desc: 'Thêm đuôi "-t" vào gốc của từ.',
    content: (
      <div className="bg-white p-3 rounded-lg border border-slate-200 text-sm mt-2">
        <p>Talo {'->'} Talo<b>t</b> (những ngôi nhà)</p>
        <p>Tyttö {'->'} Tytö<b>t</b> (những cô gái - chú ý KPT)</p>
      </div>
    )
  },
  {
    id: 'imperfekti', chapter: 'Kappale 9', title: 'Imperfekti (Thì Quá khứ)', desc: 'Dấu hiệu nhận biết là chữ "i" nằm giữa gốc từ và đuôi nhân xưng.',
    content: (
      <div className="bg-white p-3 rounded-lg border border-slate-200 text-sm mt-2">
        <p>Hiện tại: Minä asu-<b>n</b> (Tôi sống)</p>
        <p className="text-blue-700 font-medium">Quá khứ: Minä asu-<b>i</b>-<b>n</b> (Tôi đã sống)</p>
      </div>
    )
  }
];

// --- GENERATOR: BỘ TẠO LỘ TRÌNH TỰ ĐỘNG ---
const createWeek = (m, w, title, lesson1Title, lesson2Title, grammar1, grammar2) => {
  return {
    weekId: w,
    title: title,
    days: [
      {
        dayName: "Maanantai (Thứ Hai)",
        tasks: [
          { id: `m${m}w${w}d1t1`, title: "Lớp học / Tự học giáo trình", icon: <Users size={18}/>, detail: `Học bài mới: ${lesson1Title}. Ghi chép cẩn thận ngữ pháp và từ vựng.`, grammarLink: grammar1 },
          { id: `m${m}w${w}d1t2`, title: "Học từ vựng Quizlet", icon: <Monitor size={18}/>, detail: "Mở Quizlet ôn tập bộ từ vựng tương ứng với bài vừa học." },
          { id: `m${m}w${w}d1t3`, title: "Nghe nhạc Phần Lan", icon: <Music size={18}/>, detail: "Nghe các nghệ sĩ Phần Lan (Haloo Helsinki, BEHM, Käärijä) để làm quen ngữ điệu." }
        ]
      },
      {
        dayName: "Tiistai (Thứ Ba)",
        tasks: [
          { id: `m${m}w${w}d2t1`, title: "Làm một nửa bài tập về nhà", icon: <Edit3 size={18}/>, detail: `Làm các bài tập đầu tiên liên quan đến: ${lesson1Title}.` },
          { id: `m${m}w${w}d2t2`, title: "Luyện tập với ứng dụng (App)", icon: <Monitor size={18}/>, detail: "Sử dụng Duolingo hoặc WordDive 10-15 phút." },
          { id: `m${m}w${w}d2t3`, title: "Viết tay từ/cụm từ", icon: <Edit3 size={18}/>, detail: "Lấy vở nháp, chép tay 5-10 từ mới khó nhớ nhất từ bài học." },
          { id: `m${m}w${w}d2t4`, title: "Giao tiếp: Chào hỏi", icon: <MessageCircle size={18}/>, detail: "Nói 'Moi' tai 'Huomenta' với ai đó." }
        ]
      },
      {
        dayName: "Keskiviikko (Thứ Tư)",
        tasks: [
          { id: `m${m}w${w}d3t1`, title: "Làm phần bài tập còn lại", icon: <Edit3 size={18}/>, detail: `Hoàn thành nốt bài tập của phần: ${lesson1Title}.` },
          { id: `m${m}w${w}d3t2`, title: "Học từ vựng Quizlet & App", icon: <Monitor size={18}/>, detail: "Kết hợp 10p Quizlet và 10p Duolingo." },
          { id: `m${m}w${w}d3t3`, title: "Viết tay", icon: <Edit3 size={18}/>, detail: "Tự viết lại 3 câu hoàn chỉnh bằng tiếng Phần Lan." },
          { id: `m${m}w${w}d3t4`, title: "Giao tiếp: Đặt câu hỏi", icon: <MessageCircle size={18}/>, detail: "Thử đặt một câu hỏi đơn giản (vd: Mitä kuuluu? / Missä on...?)" }
        ]
      },
      {
        dayName: "Torstai (Thứ Năm)",
        tasks: [
          { id: `m${m}w${w}d4t1`, title: "Lớp học / Tự học giáo trình", icon: <Users size={18}/>, detail: `Học phần tiếp theo: ${lesson2Title}. Tích cực tham gia và ghi chép.`, grammarLink: grammar2 },
          { id: `m${m}w${w}d4t2`, title: "Đọc biển báo / Nghe xung quanh", icon: <BookOpen size={18}/>, detail: "Cố gắng tìm các từ vựng đã học trên biển báo xe buýt, siêu thị, đường phố." },
          { id: `m${m}w${w}d4t3`, title: "Nghe nhạc & Hỏi", icon: <Music size={18}/>, detail: "Vừa nghe nhạc vừa thử tự hỏi mình nội dung bài." }
        ]
      },
      {
        dayName: "Perjantai (Thứ Sáu)",
        tasks: [
          { id: `m${m}w${w}d5t1`, title: "Làm nửa bài tập (của bài Thứ Năm)", icon: <Edit3 size={18}/>, detail: `Làm bài tập ứng dụng cho: ${lesson2Title}.` },
          { id: `m${m}w${w}d5t2`, title: "Quizlet & App", icon: <Monitor size={18}/>, detail: "Chơi mini-game trên Quizlet (Match) để rèn phản xạ." },
          { id: `m${m}w${w}d5t3`, title: "Viết tay & Giao tiếp", icon: <MessageCircle size={18}/>, detail: "Chúc cuối tuần: 'Hyvää viikonloppua!'" }
        ]
      },
      {
        dayName: "Lauantai (Thứ Bảy)",
        tasks: [
          { id: `m${m}w${w}d6t1`, title: "Làm nốt bài tập còn lại", icon: <Edit3 size={18}/>, detail: "Hoàn tất mọi bài tập trong tuần. Kiểm tra lại đáp án ở cuối sách." },
          { id: `m${m}w${w}d6t2`, title: "Xem phim / Series Phần Lan", icon: <Monitor size={18}/>, detail: "Xem Moomins (Muumilaakson tarinoita) tai phim trên Yle Areena." },
          { id: `m${m}w${w}d6t3`, title: "Giao tiếp cuối tuần", icon: <MessageCircle size={18}/>, detail: "Thử bắt chuyện ngắn gọn hoặc nhắn tin cho một người bạn Phần." }
        ]
      },
      {
        dayName: "Sunnuntai (Chủ Nhật)",
        tasks: [
          { id: `m${m}w${w}d7t1`, title: "Xem phim & Tìm từ mới", icon: <Monitor size={18}/>, detail: "Tiếp tục xem phim, ghi lại 1-2 từ mới nghe được." },
          { id: `m${m}w${w}d7t2`, title: "Ota rennosti! (Thư giãn)", icon: <Coffee size={18}/>, detail: "Hôm nay là ngày nghỉ. Dành thời gian nạp lại năng lượng cho tuần mới!" }
        ]
      }
    ]
  };
};

const studyPlan = [
  {
    monthId: 1, title: "Tháng 1: Nền tảng cơ bản (Kappale 1 & 2)",
    weeks: [
      createWeek(1, 1, "Tuần 1: Xin chào & Động từ Olla (K1)", "Kappale 1: Tervehdykset (Chào hỏi) & Đại từ nhân xưng", "Kappale 1: Động từ 'Olla' & Vokaaliharmonia", "olla", "vokaaliharmonia"),
      createWeek(1, 2, "Tuần 2: Quốc tịch & Số đếm (K2)", "Kappale 2: Minkämaalainen sinä olet? (Quốc gia)", "Kappale 2: Numerot (Số đếm 1-10)", null, null),
      createWeek(1, 3, "Tuần 3: Giao tiếp tại Ki-ốt (K2)", "Kappale 2: Hội thoại tại Jätskikiskalla", "Kappale 2: Các cụm từ hỏi giá, số đếm lớn", null, null),
      createWeek(1, 4, "Tuần 4: Tổng ôn Tháng 1", "Ôn tập Kappale 1 (Olla, Chào hỏi)", "Ôn tập Kappale 2 (Quốc gia, Ngôn ngữ, Số đếm)", "olla", null),
    ]
  },
  {
    monthId: 2, title: "Tháng 2: Thời tiết & Động từ nhóm 1 (Kappale 3)",
    weeks: [
      createWeek(2, 1, "Tuần 1: Thời tiết & Tháng (K3)", "Kappale 3: Sää (Thời tiết) & Vuodenajat (Các mùa)", "Kappale 3: Kuukaudet (Các tháng trong năm)", null, null),
      createWeek(2, 2, "Tuần 2: Verbityyppi 1 (K3)", "Kappale 3: Chia động từ Nhóm 1 (puhua, asua)", "Kappale 3: Thể phủ định (en puhu, et asu)", "verb1", null),
      createWeek(2, 3, "Tuần 3: Biến âm K-P-T (K3)", "Kappale 3: Quy tắc biến đổi phụ âm (Mạnh -> Yếu)", "Kappale 3: Câu hỏi -ko/-kö (Puhutko suomea?)", "kpt", "koko"),
      createWeek(2, 4, "Tuần 4: Tổng ôn Tháng 2", "Ôn tập Verbityyppi 1 và KPT", "Luyện đọc hiểu và hội thoại Sää", "verb1", "kpt"),
    ]
  },
  {
    monthId: 3, title: "Tháng 3: Thời gian & Thói quen (Kappale 4)",
    weeks: [
      createWeek(3, 1, "Tuần 1: Xem giờ (K4)", "Kappale 4: Mitä kello on? (Mấy giờ rồi?)", "Kappale 4: Vuorokaudenajat (Các buổi trong ngày)", null, null),
      createWeek(3, 2, "Tuần 2: Động từ nhóm 2 & 3 (K4)", "Kappale 4: Verbityyppi 2 (juoda, syödä)", "Kappale 4: Verbityyppi 3 (opiskella, tulla)", "verb2_5", "verb2_5"),
      createWeek(3, 3, "Tuần 3: Động từ nhóm 4 & 5 (K4)", "Kappale 4: Verbityyppi 4 (tavata, haluta)", "Kappale 4: Verbityyppi 5 (tarvita) & Lịch trình", "verb2_5", null),
      createWeek(3, 4, "Tuần 4: Tổng ôn Tháng 3", "Luyện kể về Thói quen hàng ngày (Päivärytmi)", "Ôn tập tổng hợp 5 nhóm động từ", "verb2_5", null),
    ]
  },
  {
    monthId: 4, title: "Tháng 4: Thực phẩm & Mua sắm (Kappale 5)",
    weeks: [
      createWeek(4, 1, "Tuần 1: Đồ ăn thức uống (K5)", "Kappale 5: Ruoka ja juoma (Thực phẩm cơ bản)", "Kappale 5: Hội thoại trong siêu thị", null, null),
      createWeek(4, 2, "Tuần 2: Ngữ pháp Partitiivi (K5)", "Kappale 5: Quy tắc tạo Partitiivi (Cách phần vị)", "Kappale 5: Dùng Partitiivi với Số đếm", "partitiivi", "partitiivi"),
      createWeek(4, 3, "Tuần 3: Partitiivi mở rộng (K5)", "Kappale 5: Động từ đi kèm Partitiivi (rakastaa)", "Kappale 5: Partitiivi trong câu phủ định", "partitiivi", null),
      createWeek(4, 4, "Tuần 4: Tổng ôn Tháng 4", "Luyện viết: Danh sách đi chợ (Ostoslista)", "Ôn tập K-P-T kết hợp Partitiivi", "kpt", "partitiivi"),
    ]
  },
  {
    monthId: 5, title: "Tháng 5: Phương hướng & Sở hữu (Kappale 6 & 7)",
    weeks: [
      createWeek(5, 1, "Tuần 1: Du lịch & Vị trí (K6)", "Kappale 6: Matkustaminen & Phương tiện", "Kappale 6: Paikallissijat (Missä? Mistä? Mihin?)", null, "paikallissijat"),
      createWeek(5, 2, "Tuần 2: Luyện tập vị trí (K6)", "Kappale 6: Diễn tả chuyển động (Tới ngân hàng...)", "Kappale 6: Từ vựng các địa điểm công cộng", "paikallissijat", null),
      createWeek(5, 3, "Tuần 3: Gia đình & Sở hữu (K7)", "Kappale 7: Perhe (Gia đình) & Họ hàng", "Kappale 7: Cấu trúc Minulla on... (Tôi có)", null, "omistuslause"),
      createWeek(5, 4, "Tuần 4: Miêu tả người (K7)", "Kappale 7: Adjektiivit (Tính từ miêu tả ngoại hình)", "Tổng ôn K6 & K7 (Vị trí và Sở hữu)", null, "omistuslause"),
    ]
  },
  {
    monthId: 6, title: "Tháng 6: Quá khứ & Tổng kết (Kappale 8 & 9)",
    weeks: [
      createWeek(6, 1, "Tuần 1: Số nhiều (K8)", "Kappale 8: Monikko (Danh từ số nhiều đuôi -t)", "Kappale 8: Từ vựng Koti & Asuminen (Nhà cửa)", "monikko", null),
      createWeek(6, 2, "Tuần 2: Thì quá khứ (K9)", "Kappale 9: Imperfekti (Giới thiệu thì Quá khứ)", "Kappale 9: Chia quá khứ cho Động từ nhóm 1", "imperfekti", "imperfekti"),
      createWeek(6, 3, "Tuần 3: Quá khứ bất quy tắc (K9)", "Kappale 9: Chia quá khứ cho Động từ nhóm 2-5", "Kappale 9: Từ vựng chỉ thời gian (Eilen, Viime...)", "imperfekti", null),
      createWeek(6, 4, "Tuần 4: Tốt nghiệp Suomen Mestari 1", "Ôn tập: Kể lại một ngày cuối tuần của bạn ở Quá khứ", "Làm bài kiểm tra cuối sách. Chúc mừng hoàn thành!", "imperfekti", null),
    ]
  }
];

export default function App() {
  const [activeTab, setActiveTab] = useState('roadmap');
  const [flashcardIndex, setFlashcardIndex] = useState(0);
  const [isFlipped, setIsFlipped] = useState(false);
  
  // Vocabulary States
  const [vocabularyData, setVocabularyData] = useState(initialVocabularyData);
  const [showAddForm, setShowAddForm] = useState(false);
  const [newWord, setNewWord] = useState({ finnish: '', pronunciation: '', english: '', vietnamese: '', category: 'Oma sanasto (Từ của tôi)' });
  const [showSuccess, setShowSuccess] = useState(false);

  // Roadmap States
  const [selectedMonth, setSelectedMonth] = useState(1);
  const [selectedWeek, setSelectedWeek] = useState(1);
  const [expandedTask, setExpandedTask] = useState(null);
  const [completedTasks, setCompletedTasks] = useState({});

  // Grammar States
  const [expandedGrammarId, setExpandedGrammarId] = useState('olla');

  useEffect(() => { setIsFlipped(false); }, [flashcardIndex]);

  const toggleTaskStatus = (e, taskId) => {
    e.stopPropagation(); 
    setCompletedTasks(prev => ({ ...prev, [taskId]: !prev[taskId] }));
  };

  const toggleTaskExpand = (taskId) => {
    setExpandedTask(expandedTask === taskId ? null : taskId);
  };

  const handleGoToGrammar = (grammarId) => {
    setActiveTab('grammar');
    setExpandedGrammarId(grammarId);
    window.scrollTo({ top: 0, behavior: 'smooth' });
  };

  // Tính tiến độ (Progress)
  const currentMonthData = studyPlan.find(m => m.monthId === selectedMonth);
  const currentWeekData = currentMonthData?.weeks.find(w => w.weekId === selectedWeek);
  
  const totalTasksInWeek = currentWeekData?.days.reduce((total, day) => total + day.tasks.length, 0) || 0;
  const completedTasksInWeek = currentWeekData?.days.reduce((total, day) => {
    return total + day.tasks.filter(task => completedTasks[task.id]).length;
  }, 0) || 0;
  
  const progressPercentage = totalTasksInWeek === 0 ? 0 : Math.round((completedTasksInWeek / totalTasksInWeek) * 100);

  const nextCard = () => setFlashcardIndex((prev) => (prev + 1) % vocabularyData.length);
  const prevCard = () => setFlashcardIndex((prev) => (prev - 1 + vocabularyData.length) % vocabularyData.length);

  const handleAddWord = (e) => {
    e.preventDefault();
    if (!newWord.finnish.trim() || (!newWord.vietnamese.trim() && !newWord.english.trim())) return;

    setVocabularyData(prev => [...prev, newWord]);
    setFlashcardIndex(vocabularyData.length); // Chuyển đến thẻ mới nhất vừa tạo
    setShowAddForm(false);
    setNewWord({ finnish: '', pronunciation: '', english: '', vietnamese: '', category: 'Oma sanasto (Từ của tôi)' });

    setShowSuccess(true);
    setTimeout(() => setShowSuccess(false), 3000);
  };

  return (
    <div className="min-h-screen bg-slate-50 font-sans text-slate-800 pb-10">
      {/* Header */}
      <header className="bg-blue-700 text-white p-6 shadow-md">
        <div className="max-w-4xl mx-auto flex flex-col md:flex-row justify-between items-center">
          <div>
            <h1 className="text-3xl font-bold tracking-tight">Opi Suomea 🇫🇮</h1>
            <p className="text-blue-100 mt-1">Học Tiếng Phần Lan - Suomen Mestari 1</p>
          </div>
          <div className="mt-4 md:mt-0 bg-blue-800/50 px-5 py-3 rounded-xl backdrop-blur-sm border border-blue-600">
            <p className="text-sm font-medium text-blue-100">Kế hoạch 6 tháng</p>
            <div className="text-xl font-bold">Mục tiêu: 30 phút / ngày</div>
          </div>
        </div>
      </header>

      {/* Navigation */}
      <nav className="bg-white border-b shadow-sm sticky top-0 z-10">
        <div className="max-w-4xl mx-auto flex overflow-x-auto">
          <button onClick={() => setActiveTab('roadmap')} className={`flex items-center px-6 py-4 font-medium whitespace-nowrap transition-colors ${activeTab === 'roadmap' ? 'text-blue-600 border-b-2 border-blue-600' : 'text-slate-500 hover:text-blue-500 hover:bg-slate-50'}`}>
            <Calendar className="w-5 h-5 mr-2" />
            Lộ trình học (Roadmap)
          </button>
          <button onClick={() => setActiveTab('vocabulary')} className={`flex items-center px-6 py-4 font-medium whitespace-nowrap transition-colors ${activeTab === 'vocabulary' ? 'text-blue-600 border-b-2 border-blue-600' : 'text-slate-500 hover:text-blue-500 hover:bg-slate-50'}`}>
            <MessageCircle className="w-5 h-5 mr-2" />
            Từ vựng (Sanasto)
          </button>
          <button onClick={() => setActiveTab('grammar')} className={`flex items-center px-6 py-4 font-medium whitespace-nowrap transition-colors ${activeTab === 'grammar' ? 'text-blue-600 border-b-2 border-blue-600' : 'text-slate-500 hover:text-blue-500 hover:bg-slate-50'}`}>
            <BookOpen className="w-5 h-5 mr-2" />
            Ngữ pháp (Kielioppi)
          </button>
        </div>
      </nav>

      {/* Main Content */}
      <main className="max-w-4xl mx-auto p-4 md:p-6 mt-2">
        
        {/* TAB 1: ROADMAP */}
        {activeTab === 'roadmap' && (
          <div className="space-y-6 animate-in fade-in duration-300">
            
            <div className="bg-white rounded-xl shadow-sm p-4 border border-slate-200 flex flex-col sm:flex-row items-center gap-4 justify-between">
              <div className="flex space-x-2 w-full sm:w-auto overflow-x-auto pb-2 sm:pb-0 scrollbar-hide">
                {studyPlan.map(month => (
                  <button
                    key={month.monthId}
                    onClick={() => { setSelectedMonth(month.monthId); setSelectedWeek(1); }}
                    className={`px-4 py-2 rounded-lg text-sm font-semibold whitespace-nowrap transition-colors ${selectedMonth === month.monthId ? 'bg-blue-100 text-blue-700' : 'bg-slate-100 text-slate-600 hover:bg-slate-200'}`}
                  >
                    Tháng {month.monthId}
                  </button>
                ))}
              </div>
            </div>

            <div className="bg-white rounded-xl shadow-sm border border-slate-100 overflow-hidden">
              <div className="bg-slate-50 p-6 border-b border-slate-200">
                <div className="flex flex-col md:flex-row justify-between md:items-center gap-4">
                  <div>
                    <h2 className="text-2xl font-bold text-slate-800">{currentMonthData?.title}</h2>
                    <div className="flex gap-2 mt-3 overflow-x-auto pb-1">
                      {currentMonthData?.weeks.map(week => (
                        <button
                          key={week.weekId}
                          onClick={() => setSelectedWeek(week.weekId)}
                          className={`px-3 py-1.5 rounded-md text-sm font-medium whitespace-nowrap transition-all ${selectedWeek === week.weekId ? 'bg-blue-600 text-white shadow-md' : 'bg-white border border-slate-200 text-slate-600 hover:bg-slate-50'}`}
                        >
                          Tuần {week.weekId}
                        </button>
                      ))}
                    </div>
                  </div>

                  <div className="bg-white p-3 rounded-lg border border-slate-200 w-full md:w-48 shrink-0">
                    <div className="flex justify-between text-sm mb-1">
                      <span className="font-semibold text-slate-600">Tiến độ tuần {selectedWeek}</span>
                      <span className="font-bold text-blue-600">{progressPercentage}%</span>
                    </div>
                    <div className="w-full bg-slate-100 rounded-full h-2.5">
                      <div className="bg-blue-600 h-2.5 rounded-full transition-all duration-500" style={{ width: `${progressPercentage}%` }}></div>
                    </div>
                  </div>
                </div>
              </div>
              
              <div className="p-6">
                <p className="text-slate-600 mb-6 font-medium text-sm md:text-base bg-amber-50 text-amber-800 p-3 rounded-lg border border-amber-200">
                  💡 Lịch học bên dưới được tạo tự động dựa trên hướng dẫn học hàng ngày (Daily Routine). Nhấn vào từng nhiệm vụ để xem chi tiết bài học của tuần này.
                </p>
                
                <div className="space-y-8">
                  {currentWeekData?.days.map((dayObj, dIndex) => (
                    <div key={dIndex} className="relative pl-4 md:pl-6 border-l-2 border-blue-100">
                      <h3 className="font-bold text-lg text-blue-800 mb-4 flex items-center">
                        <span className="absolute -left-[9px] w-4 h-4 rounded-full bg-blue-500 border-4 border-white"></span>
                        {dayObj.dayName}
                      </h3>
                      
                      <div className="space-y-3">
                        {dayObj.tasks.map((task) => {
                          const isChecked = completedTasks[task.id];
                          const isExpanded = expandedTask === task.id;
                          
                          return (
                            <div key={task.id} className={`rounded-xl border transition-all duration-200 ${isChecked ? 'bg-slate-50 border-slate-200' : 'bg-white border-blue-100 shadow-sm hover:border-blue-300'}`}>
                              <div className="flex items-center justify-between p-4 cursor-pointer" onClick={() => toggleTaskExpand(task.id)}>
                                <div className="flex items-center flex-1 gap-3">
                                  <button onClick={(e) => toggleTaskStatus(e, task.id)} className={`flex-shrink-0 w-6 h-6 rounded-full border-2 flex items-center justify-center transition-all ${isChecked ? 'bg-green-500 border-green-500 text-white' : 'border-slate-300 bg-white hover:border-green-400'}`}>
                                    {isChecked && <CheckCircle className="w-4 h-4" />}
                                  </button>
                                  <div className="flex items-center gap-2">
                                    <span className={`text-slate-400 ${isChecked ? 'opacity-50' : ''}`}>{task.icon}</span>
                                    <span className={`font-semibold transition-colors ${isChecked ? 'text-slate-400 line-through' : 'text-slate-700'}`}>{task.title}</span>
                                  </div>
                                </div>
                                <div className="text-slate-400">
                                  {isExpanded ? <ChevronUp className="w-5 h-5" /> : <ChevronDown className="w-5 h-5" />}
                                </div>
                              </div>

                              {isExpanded && (
                                <div className={`px-12 pb-4 text-sm text-slate-600 animate-in slide-in-from-top-2 duration-200 ${isChecked ? 'opacity-60' : ''}`}>
                                  <div className="bg-blue-50/50 p-4 rounded-lg border border-blue-100">
                                    <span className="font-semibold text-blue-800 mb-1 block">Nhiệm vụ chi tiết:</span>
                                    {task.detail}
                                    
                                    {task.grammarLink && (
                                      <button onClick={() => handleGoToGrammar(task.grammarLink)} className="mt-3 flex items-center text-sm font-medium text-blue-600 hover:text-blue-800 bg-white border border-blue-200 hover:border-blue-400 px-3 py-1.5 rounded-md transition-colors">
                                        <BookOpen className="w-4 h-4 mr-2" /> Xem bài ngữ pháp tương ứng <ArrowRight className="w-4 h-4 ml-1" />
                                      </button>
                                    )}
                                  </div>
                                </div>
                              )}
                            </div>
                          );
                        })}
                      </div>
                    </div>
                  ))}
                </div>
              </div>
            </div>
          </div>
        )}

        {/* TAB 2 & 3: Flashcards & Grammar */}
        {activeTab === 'vocabulary' && (
          <div className="space-y-6 animate-in fade-in duration-300">
            <div className="bg-white rounded-xl shadow-sm p-6 border border-slate-100 flex flex-col items-center">
              
              {/* Header của Tab Từ Vựng */}
              <div className="w-full max-w-md flex justify-between items-center mb-2">
                <h2 className="text-2xl font-semibold">Thẻ ghi nhớ ({vocabularyData.length} từ)</h2>
                <button 
                  onClick={() => setShowAddForm(!showAddForm)}
                  className="flex items-center text-sm bg-blue-50 text-blue-700 hover:bg-blue-100 px-3 py-2 rounded-lg font-medium transition-colors"
                >
                  {showAddForm ? <X className="w-4 h-4 mr-1" /> : <Plus className="w-4 h-4 mr-1" />}
                  {showAddForm ? 'Đóng' : 'Thêm từ mới'}
                </button>
              </div>
              <p className="text-slate-600 mb-6 text-center text-sm">Nhấn vào thẻ để lật. Học từ vựng theo giáo trình hoặc thêm từ của riêng bạn.</p>
              
              {/* Thông báo thêm thành công */}
              {showSuccess && (
                <div className="w-full max-w-md bg-green-50 text-green-700 p-3 rounded-lg mb-6 text-sm font-medium flex items-center justify-center border border-green-200 animate-in fade-in slide-in-from-top-2">
                  <CheckCircle className="w-4 h-4 mr-2" />
                  Đã thêm từ vựng thành công!
                </div>
              )}

              {/* Biểu mẫu thêm từ vựng */}
              {showAddForm && (
                <form onSubmit={handleAddWord} className="w-full max-w-md bg-slate-50 p-5 rounded-xl border border-slate-200 mb-8 animate-in slide-in-from-top-2">
                  <h3 className="font-semibold text-slate-700 mb-4 text-sm uppercase tracking-wider">Thêm từ vựng mới</h3>
                  <div className="space-y-3">
                    <div>
                      <label className="block text-xs font-medium text-slate-500 mb-1">Tiếng Phần Lan *</label>
                      <input required type="text" value={newWord.finnish} onChange={e => setNewWord({...newWord, finnish: e.target.value})} className="w-full px-3 py-2 border border-slate-300 rounded-md text-sm focus:outline-none focus:ring-2 focus:ring-blue-500" placeholder="vd: Ystävä" />
                    </div>
                    <div>
                      <label className="block text-xs font-medium text-slate-500 mb-1">Phiên âm</label>
                      <input type="text" value={newWord.pronunciation} onChange={e => setNewWord({...newWord, pronunciation: e.target.value})} className="w-full px-3 py-2 border border-slate-300 rounded-md text-sm focus:outline-none focus:ring-2 focus:ring-blue-500" placeholder="vd: /ˈys.tæ.væ/" />
                    </div>
                    <div className="grid grid-cols-2 gap-3">
                      <div>
                        <label className="block text-xs font-medium text-slate-500 mb-1">Tiếng Việt *</label>
                        <input required type="text" value={newWord.vietnamese} onChange={e => setNewWord({...newWord, vietnamese: e.target.value})} className="w-full px-3 py-2 border border-slate-300 rounded-md text-sm focus:outline-none focus:ring-2 focus:ring-blue-500" placeholder="vd: Bạn bè" />
                      </div>
                      <div>
                        <label className="block text-xs font-medium text-slate-500 mb-1">Tiếng Anh</label>
                        <input type="text" value={newWord.english} onChange={e => setNewWord({...newWord, english: e.target.value})} className="w-full px-3 py-2 border border-slate-300 rounded-md text-sm focus:outline-none focus:ring-2 focus:ring-blue-500" placeholder="vd: Friend" />
                      </div>
                    </div>
                    <div>
                      <label className="block text-xs font-medium text-slate-500 mb-1">Chủ đề (Tùy chọn)</label>
                      <input type="text" value={newWord.category} onChange={e => setNewWord({...newWord, category: e.target.value})} className="w-full px-3 py-2 border border-slate-300 rounded-md text-sm focus:outline-none focus:ring-2 focus:ring-blue-500" />
                    </div>
                  </div>
                  <div className="mt-5 flex justify-end gap-2">
                    <button type="button" onClick={() => setShowAddForm(false)} className="px-4 py-2 text-sm text-slate-600 hover:bg-slate-200 rounded-md transition-colors">Hủy</button>
                    <button type="submit" className="px-4 py-2 text-sm bg-blue-600 text-white rounded-md hover:bg-blue-700 flex items-center transition-colors"><Save className="w-4 h-4 mr-2"/> Lưu từ mới</button>
                  </div>
                </form>
              )}

              <div className="w-full max-w-md">
                <div className="text-center mb-4 text-sm font-semibold text-blue-600 uppercase tracking-wider">
                  {vocabularyData[flashcardIndex]?.category || 'Chưa phân loại'}
                </div>

                <div className="relative w-full h-64 perspective-1000 cursor-pointer group" onClick={() => setIsFlipped(!isFlipped)}>
                  <div className={`w-full h-full transition-transform duration-500 transform-style-3d ${isFlipped ? 'rotate-y-180' : ''}`}>
                    <div className="absolute w-full h-full backface-hidden bg-gradient-to-br from-blue-500 to-blue-600 rounded-2xl shadow-lg flex flex-col items-center justify-center p-6 text-white text-center border-4 border-white/20">
                      <Volume2 className="absolute top-4 right-4 w-6 h-6 opacity-50 group-hover:opacity-100 transition-opacity" />
                      
                      <h3 className="text-4xl font-bold mb-2">{vocabularyData[flashcardIndex]?.finnish}</h3>
                      {/* Hiển thị phần phiên âm */}
                      {vocabularyData[flashcardIndex]?.pronunciation && (
                        <p className="text-blue-200 text-lg italic mb-4">{vocabularyData[flashcardIndex]?.pronunciation}</p>
                      )}

                      <p className="text-blue-100 text-sm opacity-80 mt-auto">Nhấn để lật thẻ</p>
                    </div>
                    
                    <div className="absolute w-full h-full backface-hidden bg-white rounded-2xl shadow-lg flex flex-col items-center justify-center p-6 text-center border border-slate-200 rotate-y-180">
                      <RefreshCw className="absolute top-4 right-4 w-5 h-5 text-slate-300 group-hover:text-blue-500 transition-colors" />
                      <div className="space-y-4">
                        <div>
                          <p className="text-xs text-slate-400 uppercase tracking-wider mb-1">Tiếng Anh</p>
                          <h3 className="text-2xl font-bold text-slate-800">{vocabularyData[flashcardIndex]?.english}</h3>
                        </div>
                        <div className="w-12 h-px bg-slate-200 mx-auto"></div>
                        <div>
                          <p className="text-xs text-slate-400 uppercase tracking-wider mb-1">Tiếng Việt</p>
                          <h3 className="text-xl font-semibold text-blue-600">{vocabularyData[flashcardIndex]?.vietnamese}</h3>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>

                <div className="flex justify-between items-center mt-8">
                  <button onClick={prevCard} className="p-3 bg-white rounded-full shadow hover:bg-slate-50 border border-slate-100 text-slate-600 hover:text-blue-600">
                    <ChevronLeft className="w-6 h-6" />
                  </button>
                  <span className="text-sm font-medium text-slate-500">{flashcardIndex + 1} / {vocabularyData.length}</span>
                  <button onClick={nextCard} className="p-3 bg-white rounded-full shadow hover:bg-slate-50 border border-slate-100 text-slate-600 hover:text-blue-600">
                    <ChevronRight className="w-6 h-6" />
                  </button>
                </div>
              </div>
            </div>
          </div>
        )}

        {activeTab === 'grammar' && (
          <div className="space-y-6 animate-in fade-in duration-300">
            <div className="bg-white rounded-xl shadow-sm p-6 border border-slate-100">
              <h2 className="text-2xl font-semibold mb-2 text-slate-800">Sổ tay Ngữ pháp (Kielioppi)</h2>
              <p className="text-slate-600 mb-6">Tổng hợp các điểm ngữ pháp trọng tâm từ Kappale 1 đến Kappale 9.</p>
              
              <div className="space-y-4">
                {grammarList.map((item) => {
                  const isExpanded = expandedGrammarId === item.id;
                  return (
                    <div key={item.id} className={`rounded-xl border transition-all duration-200 ${isExpanded ? 'border-blue-400 shadow-md ring-1 ring-blue-100' : 'border-slate-200 hover:border-blue-200'}`}>
                      <button onClick={() => setExpandedGrammarId(isExpanded ? null : item.id)} className={`w-full text-left px-5 py-4 flex items-center justify-between rounded-xl ${isExpanded ? 'bg-blue-50/50' : 'bg-white'}`}>
                        <div>
                          <span className="inline-block px-2 py-1 bg-slate-100 text-slate-500 text-xs font-semibold rounded mb-1">{item.chapter}</span>
                          <h3 className={`text-lg font-bold ${isExpanded ? 'text-blue-800' : 'text-slate-700'}`}>{item.title}</h3>
                        </div>
                        <div className={`p-2 rounded-full ${isExpanded ? 'bg-blue-100 text-blue-600' : 'bg-slate-50 text-slate-400'}`}>
                          {isExpanded ? <ChevronUp className="w-5 h-5" /> : <ChevronDown className="w-5 h-5" />}
                        </div>
                      </button>
                      
                      {isExpanded && (
                        <div className="px-5 pb-5 pt-2 border-t border-blue-100 animate-in slide-in-from-top-2 duration-200">
                          <p className="text-sm text-slate-600 mb-3">{item.desc}</p>
                          {item.content}
                        </div>
                      )}
                    </div>
                  );
                })}
              </div>
            </div>
          </div>
        )}

      </main>

      <style dangerouslySetInnerHTML={{__html: `
        .perspective-1000 { perspective: 1000px; }
        .transform-style-3d { transform-style: preserve-3d; }
        .backface-hidden { backface-visibility: hidden; }
        .rotate-y-180 { transform: rotateY(180deg); }
        .scrollbar-hide::-webkit-scrollbar { display: none; }
        .scrollbar-hide { -ms-overflow-style: none; scrollbar-width: none; }
      `}} />
    </div>
  );
}