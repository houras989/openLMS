# -*- coding: utf-8 -*-
from PIL import Image
from reportlab.lib import colors

from reportlab.pdfgen.canvas import Canvas
from reportlab.lib.pagesizes import letter
from reportlab.lib.units import mm, inch
from reportlab.lib.styles import ParagraphStyle, getSampleStyleSheet
from reportlab.platypus import Paragraph
from reportlab.pdfbase.ttfonts import TTFont
from reportlab.pdfbase import pdfmetrics
from reportlab.platypus.tables import Table, TableStyle

import locale
import warnings

_ = lambda x: x

class UnicodeProperty(object):
    _attrs = ()

    def __setattr__(self, key, value):
        if key in self._attrs:
            value = unicode(value)
        self.__dict__[key] = value

class NumberedCanvas(Canvas):
    def __init__(self, *args, **kwargs):
        Canvas.__init__(self, *args, **kwargs)
        self._saved_page_states = []

    def showPage(self):
        self._saved_page_states.append(dict(self.__dict__))
        self._startPage()

    def save(self):
        """add page info to each page (page x of y)"""
        num_pages = len(self._saved_page_states)
        for state in self._saved_page_states:
            self.__dict__.update(state)
            if num_pages > 1:
                self.draw_page_number(num_pages)
            Canvas.showPage(self)
        Canvas.save(self)

    def draw_page_number(self, page_count):
        self.setFont("DejaVu", 7)
        self.drawRightString(200*mm, 20*mm,
            _("Page %(page_number)d of %(page_count)d") % {"page_number": self._pageNumber, "page_count": page_count})


def prepare_invoice_draw(self):
    self.MARGIN = 15
    FONT_PATH = '/usr/share/fonts/truetype/ttf-dejavu/DejaVuSans.ttf'
    FONT_BOLD_PATH = '/usr/share/fonts/truetype/ttf-dejavu/DejaVuSans-Bold.ttf'

    pdfmetrics.registerFont(TTFont('DejaVu', FONT_PATH))
    pdfmetrics.registerFont(TTFont('DejaVu-Bold', FONT_BOLD_PATH))

    self.pdf = NumberedCanvas(self.filename, pagesize=letter)

    self.pdf.setFont('DejaVu', 15)
    self.pdf.setStrokeColorRGB(0.5, 0.5, 0.5)
    self.pdf.setLineWidth(0.353 * mm)


#Fix for http://bugs.python.org/issue15276.
def fix_grouping(bytestring):
    try:
        return unicode(bytestring)
    except UnicodeDecodeError:
        return bytestring.decode("utf-8")


def currency(amount):
    return fix_grouping(locale.currency(amount, grouping=True)).replace(u",00 Kč", u",- Kč   ")


class SimpleInvoice(UnicodeProperty):

    def gen(self, filename):
        self.filename = filename

        prepare_invoice_draw(self)

        self.drawBorders()
        self.drawLogos('/edx/app/edxapp/edx-platform/lms/static/images/wl_logo.gif', '/edx/app/edxapp/edx-platform/lms/static/images/logo-edX-77x36.png')

        self.drawTitle('RECEIPT', '23', '23 Feb, 2014')
        y_pos = self.drawCourseInfo()
        self.calculate_total(y_pos, '44.00', '30.00', '14.00')
        self.drawFooter(y_pos)
        # self.pdf.setFillColorRGB(0, 0, 0)

        self.pdf.showPage()
        self.pdf.save()

    #############################################################
    ## Draw methods
    #############################################################

    def drawBorders(self):
        # Borders
        self.pdf.rect(self.MARGIN * mm, self.MARGIN * mm,
                      186 * mm, 249 * mm, stroke=True, fill=False)

    def drawLogos(self, wl_logo, edx_logo):
        im = Image.open(wl_logo)
        height = 12
        top = 240
        width = float(im.size[0]) / (float(im.size[1])/height)
        self.pdf.drawImage(wl_logo, (self.MARGIN + 9) * mm, top * mm, width * mm, height*mm)

        im = Image.open(edx_logo)
        width = float(im.size[0]) / (float(im.size[1])/height)
        self.pdf.drawImage(edx_logo, (self.MARGIN + 177 -width) * mm, top * mm, width * mm, height*mm)

    def drawTitle(self, title, order_number, purchase_date):
        self.pdf.setFont('DejaVu', 21)
        self.pdf.drawCentredString(108*mm, (230)*mm, title)

        self.pdf.setFont('DejaVu', 10)
        self.pdf.drawString((self.MARGIN + 8) * mm, 220 * mm, _(u'Order # ' + order_number))
        self.pdf.drawRightString((self.MARGIN + 177) * mm, 220 * mm, _(u'Date ' + purchase_date))

    def drawCourseInfo(self):

        data= [['', 'Description', 'Quantity', 'List Price \n per item', 'Discount \n per item', 'Amount', ''],
        ['', 'Demo Course', '2', '2$', '0$', '22$', ''],
        ['', 'Demo Course', '2', '2$', '0$', '22$', ''],
        ['', 'Demo Course', '2', '2$', '0$', '22$', '']
        ]
        heights = [12*mm]
        heights.extend((len(data) - 1 )*[8*mm])
        t=Table(data,[7*mm, 60*mm, 27*mm, 21*mm,21*mm, 40*mm, 7*mm], heights)

        t.setStyle(TableStyle([('ALIGN',(1,1),(-2,-2),'RIGHT'),
        ('VALIGN',(0,0),(0,-1),'TOP'),
        ('ALIGN',(0,0),(-1,-1),'CENTER'),
        ('VALIGN',(0,0),(-1,-1),'MIDDLE'),
        ('TEXTCOLOR',(0,-1),(-1,-1),colors.black),
        # ('LINEABOVE', (0,0), (-1,0), .25, colors.black),
        ('LINEBELOW', (0,0), (-1,0), .25, colors.black),
        ('LINEBELOW', (0,-1), (-1,-1), .25, colors.black),
        ('INNERGRID', (1,1), (-2,-1), 0.25, colors.black),
        # ('BOX', (1,1), (-1,-1), 0.25, colors.black),
        ]))
        t.wrap(0,0)
        t.drawOn(self.pdf, (self.MARGIN +2) * mm, (205 * mm) -t._height)
        return ((205 * mm) -t._height)/ mm

    def calculate_total(self, y_pos, total_amount, payment_received, balance):
        self.pdf.setFillColorRGB(0.823, 0.823, 0.823)
        self.pdf.setStrokeColorRGB(0.5, 0.5, 0.5)

        self.pdf.rect((self.MARGIN + 142) * mm, (y_pos - 12) * mm, 33 * mm, 7 * mm, stroke=True, fill=1)

        self.pdf.setFillColorRGB(0, 0, 0)
        self.pdf.setFont('DejaVu', 10)
        self.pdf.drawString((self.MARGIN + 131) * mm, (y_pos - 10) * mm, _(u'Total'), 0)

        self.pdf.setFont('DejaVu', 8)
        self.pdf.drawRightString((self.MARGIN + 170) * mm, (y_pos - 10) * mm, _('$' + total_amount), 0)

        self.pdf.setFillColorRGB(0.823, 0.823, 0.823)
        self.pdf.rect((self.MARGIN + 142) * mm, (y_pos - 21) * mm, 33 * mm, 7 * mm, stroke=True, fill=1)

        self.pdf.setFont('DejaVu', 8)
        self.pdf.setFillColorRGB(0, 0, 0)
        self.pdf.drawString((self.MARGIN + 114) * mm, (y_pos - 19) * mm, _(u'Payment Received'), 0)

        self.pdf.setFont('DejaVu', 8)
        self.pdf.drawRightString((self.MARGIN + 170) * mm, (y_pos - 19) * mm, _('$' + payment_received), 0)

        self.pdf.setFillColorRGB(0.823, 0.823, 0.823)
        self.pdf.rect((self.MARGIN + 142) * mm, (y_pos - 30) * mm, 33 * mm, 7 * mm, stroke=True, fill=1)

        self.pdf.setFont('DejaVu', 10)
        self.pdf.setFillColorRGB(0, 0, 0)
        self.pdf.drawString((self.MARGIN + 126) * mm, (y_pos - 28) * mm, _(u'Balance'), 0)

        self.pdf.setFont('DejaVu', 8)
        self.pdf.drawRightString((self.MARGIN + 170) * mm, (y_pos - 28) * mm, _('$' + balance), 0)

        self.pdf.setFont('DejaVu', 10)
        self.pdf.drawRightString((self.MARGIN + 174) * mm, (y_pos - 36) * mm, _(u'EdX Tax ID:  46-0807740'), 0)

    def drawFooter(self, y_pos):
        self.pdf.setFillColorRGB(0.823, 0.823, 0.823)
        self.pdf.setStrokeColorRGB(0.5, 0.5, 0.5)
        self.pdf.rect((self.MARGIN + 11) * mm, (y_pos - 49) * mm, 161 * mm, 8 * mm, stroke=True, fill=1)

        self.pdf.setFont('DejaVu', 8)
        self.pdf.setFillColorRGB(0, 0, 0)
        self.pdf.drawString((self.MARGIN + 17) * mm, (y_pos - 46) * mm, _('Edx As a service provider'), 0)

        self.pdf.setFont('DejaVu', 8)
        self.pdf.setFillColorRGB(0, 0, 0)
        # textobject = self.pdf.beginText((self.MARGIN + 17) * mm, (y_pos - 62) * mm)
        # textobject.textOut("Hello World123456")
        # textobject.textLine(text='')
        # self.pdf.drawText(textobject)

        self.pdf.drawString((self.MARGIN + 12) * mm, (y_pos - 55) * mm, _('TERMS AND CONDITIONS'), 0)

        self.pdf.setFont('DejaVu', 10)
        self.pdf.drawString((self.MARGIN + 12) * mm, (y_pos - 70) * mm, _('EdX Billing Address'), 0)

        text = """
Enrollments:<br/>
Enrollments must be completed within 7 full days from the course start date.<br/>
Payment Terms:<br/>
Payment is due immediately. Preferred method of payment is wire transfer. Full instructions and remittance details will be included on your official invoice. Please note that our terms are net zero. For questions regarding payment instructions or extensions, please contact onlinex-registration@mit.edu and include the words "payment question" in your subject line.<br/>
Cancellations:<br/>
Cancellation requests must be submitted to onlinex-registration@mit.edu 14 days prior to the course start date to be eligible for a refund. If you submit a cancellation request within 14 days prior to the course start date, you will not be eligible for a refund. Please see our Terms of Service page for full details.<br/>
Substitutions:<br/>
The MIT Professional Education Online X Programs office must receive substitution requests before the course start date in order for the request to be considered. Please email onlinex-registration@mit.edu to request a substitution.<br/>
Please see our Terms of Service page for our detailed policies, including terms and conditions of use.
            """

        style = getSampleStyleSheet()['Normal']
        style.backColor = '#D0D0D0'
        style.borderColor = '#000000'
        style.borderWidth = 0.5
        style.borderPadding = (2*mm, 5*mm, 2*mm, 5*mm)
        style.fontSize = 8
        para = Paragraph(text, style)
        para.wrap(151 * mm, 7*mm)
        para.drawOn(self.pdf, (self.MARGIN + 11+5) * mm, (y_pos - 150) * mm)
